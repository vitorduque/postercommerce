class AdminController < ApplicationController
  require '/home/vitor/RailsProjects/postercommerce/app/validations/auth_admin.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/models/order_item_dao.rb'

  def index
    if session[:admin_signed_in] == true
    render 'index'
    else
      @login = Login.new()
      render 'login'
    end
  end

  def admin_log_in
    @login = Login.new(params.require(:login).permit(:email, :password))
    auth = AdminLoginAuth.new()
    result = auth.auth(@login.email, @login.password)
    if result.class.to_s.eql? TrueClass.to_s
      session[:admin_signed_in] = true
      redirect_to controller: 'admin', action: 'index'
    else
      @login.errors.add("Errors: ", result)
      render 'login'
    end
  end

  def analisys
    @graph = Graph.new
    render 'analisys'
  end

  def gerenate_graph
    @graph = Graph.new(params.require(:graph).permit(:begin, :end))
    if @graph.begin.blank? or @graph.end.blank?
      @graph.errors.add("Error:", "Select a range date!")
      flash[:notice] = 'Select a date range'
      redirect_to controller:'admin', action: 'analisys'
    else
      @graph.begin << " 00:00:00"
      @graph.end << " 23:59:59"
      order_items = OrderItem.new
      dao = ItemDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
      order_items = dao.retrieve_graph(@graph)
      if order_items.length.eql? 0
        flash[:notice] = 'No datas received'
        redirect_to controller:'admin', action: 'analisys'
      else
        binding.pry
        @graph.mine_order_items(order_items)
        render 'graph_view'
      end
    end


  end

  def admin_log_out
    session[:admin_signed_in] = false
    redirect_to controller: 'admin', action: 'index'
  end
end
