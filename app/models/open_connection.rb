class OpenConnection

  def initialize(host, user, pass, port, database)
    @host = host
    @username = user
    @pass = pass
    @port = port
    @database = database
  end

  def open
    connection = nil
    connection = Mysql2::Client.new(
      host: @host,
      username: @username,
      password: @pass,
      port: @port,
      database: @database
    )

    if connection.ping
      p "conectou!"
      return connection
    else
      p "erooooooooou"
    end

  end
end
