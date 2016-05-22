class ClientDao

  def initialize(conn)
    @connection = conn
  end

  def create(client)
    client.created_at = Time.now.to_s(:db)
    client.updated_at = Time.now.to_s(:db)
    db = @connection.open
    db.query("insert into clients
    (name, gender, born_date, email, password, cpf, street, number, neighborhood, city,
    state, zip_code, complement, created_at, updated_at)
          VALUES('#{client.name}',
          '#{client.gender}',
          '#{client.born_date}',
          '#{client.login.email}',
          '#{client.login.password}',
          '#{client.cpf}',
          '#{client.address.street}',
          '#{client.address.number}',
          '#{client.address.neighborhood}',
          '#{client.address.city}',
          '#{client.address.state}',
          '#{client.address.zip_code}',
          '#{client.address.complement}',
          '#{client.created_at}',
          '#{client.updated_at}' )")
  end

  def find(id)
    db = @connection.open
    unique_result = db.query("SELECT * FROM clients WHERE id = #{id}")
    client = Client.new

    unique_result.each do |row|
      client.id = row['id']
      client.name = row['name']
      client.email = row['email']
      client.street = row['street']
      client.number = row['number']
      client.neighborhood = row['neighborhood']
      client.city = row['city']
      client.state = row['state']
      client.complement =  row['complement']
      client.zip_code = row['zip_code']
    end
    db.close
    client
  end

  def find_by_email(email)
    db = @connection.open
    user = Client.new()
    result = db.query("SELECT * FROM clients where email = '#{email}'")

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

  def find_by_cpf(cpf)
    db = @connection.open
    user = Client.new()
    result = db.query("SELECT * FROM clients where cpf = '#{cpf}'")

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

  def edit(client)
    updated_at = updated_at = Time.now.to_s(:db)
    db = @connection.open
    db.query("update clients set street = '#{client.address.street}',
    number = '#{client.address.number}',
    neighborhood = '#{client.address.neighborhood}',
    city = '#{client.address.city}',
    state = '#{client.address.state}',
    zip_code = '#{client.address.zip_code}',
    complement = '#{client.address.complement}',
    updated_at = '#{updated_at}'
    where id = '#{client.id}'")
  end
end
