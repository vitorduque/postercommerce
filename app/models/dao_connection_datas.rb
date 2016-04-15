class DaoConnectionData

  HOST = 'localhost'
  PORT = '3306'
  DATABASE_NAME = 'appmysql_development'
  USER = 'root'
  PASSWORD = 'root'

  attr_accessor :host, :port, :database_name, :user, :password

  def initialize
    @host = HOST
    @port = PORT
    @database_name = DATABASE_NAME
    @user = USER
    @password = PASSWORD
  end

end
