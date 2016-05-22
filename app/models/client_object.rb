class ClientObject < Domain

  #id, created_at, updated_at herdando de domain
  attr_accessor :name, :cpf, :login, :address, :gender, :born_date

  def initialize(id ,name, cpf, login, address, gender, born_date)
    @id = id
    @name = name
    @cpf = cpf
    @login = login
    @address = address
    @gender = gender
    @born_date = born_date
  end

end
