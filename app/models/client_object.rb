class ClientObject < Domain

  #id, created_at, updated_at herdando de domain
  attr_accessor :name, :cpf, :login, :address

  def initialize(name, cpf, login, address)
    @name = name
    @cpf = cpf
    @login = login
    @address = address
  end

end
