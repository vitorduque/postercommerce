class ExistingCpfValidation

  def validate(client)
    dao = ClientDao.new(OpenConnection.new('localhost', 'root', 'root', '3306', 'appmysql_development'))
    user = dao.find_by_email(client.login.email)
    if user.email.nil?
      ""
    else
      "Email already in use"
    end
  end
end
