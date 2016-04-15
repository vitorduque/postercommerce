class OrdersController < ApplicationController
  require '/home/vitor/RailsProjects/LES/app/models/order_item_dao.rb'

  def index

    if session[:signed_in]
      @orders = get_orders(session[:user_id])
      render 'my_orders'
    else
      redirect_to controller: 'login', action: 'index'
    end
  end

  def show
    @items = find_items(session[:user_id], params[:id])
    @order = get_order_by_id(params[:id])

    if @items.empty?
      index
    else
      render 'show'
    end
  end

  def create
    @order = Order.new(params.require(:order).permit(:total_price, :payment_method, :client_id, :shipping_method))
    @order.client_id = session[:user_id]
    @shipping_price = {"FedEX" => 12.30, "USPS" => 10, nil => 0}
    @order.total_price = @order.total_price.to_f + @shipping_price[@order.shipping_method]
    get_client
    if user_signed_in?
      if session[:cart_signed_in][session[:user_id].to_s].empty?
        @order.errors.add("Error: ", "Your cart is empty ")
        render '/cart/cart'
      else

        result = @command['create'].execute(@order)
        if result.nil?
          insert_items(session[:cart_signed_in][session[:user_id].to_s], @order.client_id, get_last_order_by_id(@order.client_id))
          SendOrder.send_order_email(@client, @order).deliver
          session[:cart_signed_in] = nil
          redirect_to root_path
        else
          @order.errors.add("Errors: ", result)
          render '/cart/cart'
        end
      end
    else
      redirect_to controller: 'login', action: 'index'
    end

  end

  def cancel_order
    @order = get_order_by_id(params[:id])
    get_client
    if session[:user_id].eql? @order.client_id
      OrderCanceled.send_canceled_email(@client, @order).deliver
      cancel_order_by_id(params[:id])
      redirect_to controller: 'orders', action: 'index'
    else
      index
    end
  end


private
  def user_signed_in?
    if session[:signed_in]
      true
    else
      false
    end
  end

  def get_orders(client_id)
    dao = OrderDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
    dao.get_orders(client_id)
  end

  def insert_items(cart, client_id, order_id)
    dao_item = ItemDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
    dao_item.create(cart, client_id, order_id)
  end

  def find_items(client_id, order_id)
    dao_item = ItemDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
    dao_item.find_items(client_id, order_id)
  end

  def get_last_order_by_id(id)
    dao = OrderDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
    dao.get_last_order(id)
  end

  def get_order_by_id(id)
    dao = OrderDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
    dao.find(id)
  end

  def get_client
    if session[:signed_in]
      dao = ClientDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
      @client = dao.find(session[:user_id])
    end
  end

  def cancel_order_by_id(order_id)
    dao = OrderDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
    dao.cancel_order(order_id)
  end

end
