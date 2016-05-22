class Client < Domain

  #id, created_at, updated_at herdando de domain
  attr_accessor :name, :email, :password, :cpf, :complement, :number, :street, :neighborhood, :city, :state, :zip_code, :confirm_password, :gender, :born_date

end
