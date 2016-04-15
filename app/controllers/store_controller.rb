class StoreController < ApplicationController


  def index
    @cart_item = CartItem.new
    if user_signed_in?
      if session[:cart_signed_in].nil?
        session[:cart_signed_in] = Hash.new
        session[:cart_signed_in][session[:user_id].to_s] = Array.new
      end
    elsif session[:cart].nil?
      session[:cart] = Array.new
    end
    @list = Array.new
    @posters = @command['list'].execute(Poster.new)
    render 'store'
  end

  def show
    @cart_item = CartItem.new
    @poster = @command['show'].execute(Poster.new(id: params[:id]))
    if @poster == false
      redirect_to controller: 'posters', action: 'index', notice: 'Error: No ID reached out'
    else
      render 'show'
    end
  end


  def  my_cart
    @order = Order.new()
    get_client
    render '/cart/cart'
  end
private
  def user_signed_in?
    if session[:signed_in]
      true
    else
      false
    end
  end

  def get_client
    if session[:signed_in]
      dao = ClientDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
      @client = dao.find(session[:user_id])
    end
  end

end
