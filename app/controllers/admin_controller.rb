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
    @graph = Graph.new(params.require(:graph).permit(:begin, :end))
    @graph.begin << " 00:00:00"
    @graph.end << " 23:59:59"
    result1 = @command['graphs'].execute(@graph, 1)
    result2 = @command['graphs'].execute(@graph, 2)
    result3 = @command['graphs'].execute(@graph, 3)

    if result1.is_a?(String)
      @graph.errors.add("Errors: ", result1)
      render 'analisys'
    else
      @graph.mine_order_items(result1[0], result1[1])
      @graph.graph_category_sex(result2[0], result2[1])
      @graph.datas_graph_three(result3)

      render 'graph_view'

    end

  end

  def admin_log_out
    session[:admin_signed_in] = false
    redirect_to controller: 'admin', action: 'index'
  end
end
