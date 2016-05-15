class ClientObject < Domain

  #id, created_at, updated_at herdando de domain
  attr_accessor :name, :cpf, :login, :address, :gender

  def initialize(id ,name, cpf, login, address, gender)
    @id = id
    @name = name
    @cpf = cpf
    @login = login
    @address = address
    @gender = gender
  end

end
