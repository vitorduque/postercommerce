class GraphReturnValidation

  def validate(graph)
    dao_conn_data = DaoConnectionData.new
    dao = GraphDao.new(OpenConnection.new(dao_conn_data.host, dao_conn_data.user,dao_conn_data.password,dao_conn_data.port,dao_conn_data.database_name))
    datas = dao.return_orders(graph)
    if datas.blank?
      "No datas found"
    else
      ""
    end
  end


end
