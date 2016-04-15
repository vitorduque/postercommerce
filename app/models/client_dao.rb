class ClientDao

  def initialize(conn)
    @connection = conn
  end

  def create(client)
    client.created_at = Time.now.to_s(:db)
    client.updated_at = Time.now.to_s(:db)
    db = @connection.open
    db.query("insert into clients
    (name, email, password, cpf, street, number, neighborhood, city,
    state, zip_code, complement, created_at, updated_at)
          VALUES('#{client.name}',
          '#{client.email}',
          '#{client.password}',
          '#{client.cpf}',
          '#{client.street}',
          '#{client.number}',
          '#{client.neighborhood}',
          '#{client.city}',
          '#{client.state}',
          '#{client.zip_code}',
          '#{client.complement}',
          '#{client.created_at}',
          '#{client.updated_at}' )")
  end

  def find(id)
    db = @connection.open
    unique_result = db.query("SELECT * FROM clients WHERE id = #{id}")
    client = Client.new()

    unique_result.each do |row|
      client.id = row['id']
      client.name = row['name']
      client.email = row['email']
      client.street = row['street']
      client.number = row['number']
      client.neighborhood = row['neighborhood']
      client.city = row['city']
      client.state = row['state']
      client.zip_code = row['zip_code']
      client.complement =  row['complement']
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
    db.query("update clients set street = '#{client.street}',
    number = '#{client.number}',
    neighborhood = '#{client.neighborhood}',
    city = '#{client.city}',
    state = '#{client.state}',
    zip_code = '#{client.zip_code}',
    complement = '#{client.complement}',
    updated_at = '#{updated_at}'
    where id = '#{client.id}'")
  end
end
