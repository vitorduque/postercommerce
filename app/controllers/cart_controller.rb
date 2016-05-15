class CartController < ApplicationController

  def add_to_cart

    #binding.pry
    #poster = @command['show'].execute(Poster.new(id: params[:cart_item]["item_id"]))
    poster = @command['show'].execute(PosterObject.new(params[:cart_item]["item_id"],nil,nil,nil,nil,nil,nil,nil,nil,nil,nil))

    price = {"Small" => poster.price_small,
                     "Medium" => poster.price_medium,
                     "Large" => poster.price_large}
    @cart_item = CartItem.new(params.require(:cart_item).permit(:item_id, :category, :name, :size, :amount))
    @cart_item.unit_price = price[@cart_item.size]
    if @cart_item.is_number?(@cart_item.amount)
      #Verify if item is already on cart.
      #   return: index of the item on cart or false
      if session[:signed_in]
        session[:cart_signed_in][session[:user_id].to_s] = session[:cart_signed_in][session[:user_id].to_s] - [nil]
        x = @cart_item.cart_item_already_exists?(@cart_item, session[:cart_signed_in][session[:user_id].to_s])
        y = @cart_item.category_already_exists?(@cart_item, session[:cart_signed_in][session[:user_id].to_s])
        if !x
          session[:cart_signed_in][session[:user_id].to_s] << @cart_item
        else
          if !y
            session[:cart_signed_in][session[:user_id].to_s] << @cart_item
          else
            new_amount = @cart_item.new_amount(@cart_item, session[:cart_signed_in][session[:user_id].to_s][y])
            session[:cart_signed_in][session[:user_id].to_s][y]["amount"] = new_amount.to_s
          end
        end
      else

        x = @cart_item.cart_item_already_exists?(@cart_item, session[:cart] )
        y = @cart_item.category_already_exists?(@cart_item, session[:cart] )
        if !x
          session[:cart] << @cart_item
        else
          if !y
            session[:cart] << @cart_item
          else
            new_amount = @cart_item.new_amount(@cart_item, session[:cart][y])
            session[:cart][y]["amount"] = new_amount
          end
        end
      end
      redirect_to controller: 'store', action: 'my_cart'
    else
      @cart_item.errors.add("Erro: ", "Amount must be a number")
      redirect_to controller: 'store', action: 'index', notice: 'Error: Amount must be a number'
    end
  end

  def index
    @order = Order.new
    get_client
    render 'cart'
  end

  def empty_cart
    session[:cart] = Array.new
    if session[:signed_in]
      session[:cart_signed_in][session[:user_id].to_s] = Array.new
    end

    redirect_to controller: 'store', action: 'my_cart'
  end
private
    def get_client
      if session[:signed_in]
        dao = ClientDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
        @client = dao.find(session[:user_id])
      end
    end
end
