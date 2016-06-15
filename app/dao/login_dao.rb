class LoginDao


  def initialize(conn)
    @connection = conn
  end

  def find_by_email(email)
    db = @connection.open
    user = Client.new()
    result = db.query("SELECT * FROM clients where email = '#{email}'")


    if result.count == 0
      false
    end

    result.each do |row|
      user.id = row['id']
      user.name = row['name']
      user.email = row['email']
      user.password = row['password']
      user.cpf =  row['cpf']
      user.street = row['street']
      user.number = row['number']
      user.neighborhood = row['neighborhood']
      user.city = row['city']
      user.state = row['state']
      user.zip_code = row['zip_code']
      user.complement = row['complement']
    end

    db.close
    user
  end

end
