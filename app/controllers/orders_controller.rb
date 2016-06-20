class OrdersController < ApplicationController
  require '/home/vitor/RailsProjects/postercommerce/app/dao/order_item_dao.rb'

  def index
    if session[:signed_in]
      #@orders = get_orders(session[:user_id])
      @orders = @command['get_orders_by_id'].execute(Order.new(client_id: session[:user_id]))

      render 'my_orders'
    else
      redirect_to controller: 'login', action: 'index'
    end
  end

  def show
    @items = find_items(session[:user_id], params[:id])
    @order = get_order_by_id(params[:id])
    @sizes = Array.new
    @max = Array.new
    @items.each do |i|
      @max << i.amount
    end
    if params[:values].nil?
      @values = Array.new
      @items.each do |i|
        @values << 0
      end
    else
      @items.each do |i|
        if i.size.eql? "Small"
          @sizes << i.price_small
        elsif i.size.eql? "Medium"
          @sizes << i.price_medium
        else
          @sizes << i.price_large
        end
      end

      @values = params[:values]
      @values.each_with_index do |v, i|
        @values[i] = v.to_i
      end
      if params[:increment].to_i.eql? 1
        if params[:increment].to_i > @max[params[:item].to_i]
          render 'show'
        elsif @values[params[:item].to_i] < @max[params[:item].to_i]
          @values[params[:item].to_i] += params[:increment].to_i
          render 'show'
        end
      elsif params[:decrement].to_i.eql?1
        if @values[params[:item].to_i].eql? 0
          render 'show'
        else
          @values[params[:item].to_i] -= params[:decrement].to_i
          render 'show'
        end
      else
        render 'show'
      end
    end

  end

  def create
    @order = Order.new(params.require(:order).permit(:total_price, :payment_method, :client_id, :shipping_method, :id_voucher))
    @voucher = @command['show'].execute(Voucher.new(id_voucher: @order.id_voucher))
    @order.client_id = session[:user_id]
    @shipping_price = {"FedEX" => 12.30, "USPS" => 10, nil => 0}
    @order.total_price = @order.total_price.to_f + @shipping_price[@order.shipping_method]
    get_client
    if user_signed_in?
      if session[:cart_signed_in][session[:user_id].to_s].empty?
        flash[:notice] = "Your cart is empty "
        redirect_to controller: 'cart', action: 'index'
      else
        if @voucher.id_voucher.nil?
          result = @command['create'].execute(@order)
        else
          voucher_price = @voucher.price.to_f
          order_price = @order.total_price.to_f
          if voucher_price >= order_price
            @order.total_price = 0
          else
            @order.total_price = order_price - voucher_price
            @order.total_price = @order.total_price.round(2)
          end
          result = @command['create'].execute(@order)
          result2 = @command['edit'].execute(@voucher)
        end
        if result.nil? and result2.nil?
          order_id = @command['get_last_order_by_id'].execute(@order)
          #binding.pry
          insert_items(session[:cart_signed_in][session[:user_id].to_s], @order.client_id, order_id)
          SendOrder.send_order_email(@client, @order, session[:cart_signed_in][session[:user_id].to_s]).deliver
          session[:cart_signed_in] = nil
          redirect_to root_path
        else
          @order.errors.add("Errors: ", result)
          flash[:notice] = result
          redirect_to controller: 'cart', action: 'index'
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
      cancel_order_by_id(Order.new(id: params[:id]))
      redirect_to controller: 'orders', action: 'index'
    else
      index
    end
  end

  def complain_order
    
    @order = get_order_by_id(params[:order][:id])
    @order.total_price = params[:order][:total_price].to_f
    get_client
    if not params[:order][:total_price].to_f < 1
      if session[:user_id].eql? @order.client_id
        ComplainOrder.send_complained_email(@client, @order).deliver
        complain_order_by_id(@order)
        redirect_to controller: 'orders', action: 'index'
      else
        index
      end
    else
      flash[:notice] = "Error: select your products"
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

  #Call to command array
  def complain_order_by_id(order)
    @command['complain_order_by_id'].execute(order)
  end

  def cancel_order_by_id(order)
    @command['cancel_order_by_id'].execute(order)
    #dao = OrderDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
    #dao.cancel_order(order_id)
  end

  #Call to command array
  def get_order_by_id(id)
    @command['show'].execute(Order.new(id: id))
    #dao = OrderDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
    #dao.find(id)
  end

  #Call to command array
  def get_client
    if session[:signed_in]
      #dao = ClientDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
      #@client = dao.find(session[:user_id])
      #@client = @co  mmand['show'].execute(Client.new(id: session[:user_id]))
      @client = @command['show'].execute(Client.new(id: session[:user_id].to_s))
    end
  end

  def insert_items(cart, client_id, order_id)
    #binding.pry
    #teste = Cart.new(cart: cart, client_id: client_id, order_id: order_id)
    @error = @command['create'].execute(Cart.new(cart: cart, client_id: client_id, order_id: order_id))
    #dao_item = ItemDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
    #dao_item.create(cart, client_id, order_id)
  end

  def find_items(client_id, order_id)
    @items = @command['show'].execute(Cart.new(client_id: client_id, order_id: order_id))
    #dao_item = ItemDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
    #dao_item.find_items(client_id, order_id)
  end


end
