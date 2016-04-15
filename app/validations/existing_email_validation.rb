class ExistingEmailValidation

  def validate(client)
    dao = ClientDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
    user = dao.find_by_cpf(client.cpf)
    if user.cpf.nil?
      ""
    else
      "Cpf already in use"
    end
  end
end
