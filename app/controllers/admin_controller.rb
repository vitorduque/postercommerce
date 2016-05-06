class AdminController < ApplicationController
  require '/home/vitor/RailsProjects/postercommerce/app/validations/auth_admin.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/models/order_item_dao.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/models/dao_connection_datas.rb'
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
    dao_conn_data = DaoConnectionData.new()
    @graph = Graph.new(params.require(:graph).permit(:begin, :end))
    if @graph.begin.blank? or @graph.end.blank?
      @graph.errors.add("Error:", "Select a range date!")
      flash[:notice] = 'Select a date range'
      redirect_to controller:'admin', action: 'analisys'
    else
      @graph.begin << " 00:00:00"
      @graph.end << " 23:59:59"
      dao = ItemDao.new(OpenConnection.new(dao_conn_data.host, dao_conn_data.user,dao_conn_data.password,dao_conn_data.port,dao_conn_data.database_name))
      trash_return = dao.retrieve_graph(@graph)
      if trash_return[0].length.eql? 0
        flash[:notice] = 'No datas received'
        redirect_to controller:'admin', action: 'analisys'
      else
        @graph.mine_order_items(trash_return[0], trash_return[1])
        @names = @graph.names
        @amount = @graph.amount
        render 'graph_view'
      end
    end


  end

  def admin_log_out
    session[:admin_signed_in] = false
    redirect_to controller: 'admin', action: 'index'
  end
end
