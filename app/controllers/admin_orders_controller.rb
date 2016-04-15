class AdminOrdersController < ApplicationController

  def index
    if session[:admin_signed_in]
      @orders = @command['list'].execute(Order.new)
      render :index
    else
      redirect_to controller: 'admin'
    end
  end

  def set
    @order = @command['show'].execute(Order.new(id: params[:id]))
    if @order.id.nil?
      redirect_to controller: 'admin_orders', action: 'index', notice: 'Error: No ID reached out'
    end
    result = @command['set'].execute(@order)
    redirect_to controller: 'admin_orders'
  end

end
