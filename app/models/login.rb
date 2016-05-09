class Login
  include ActiveModel::Model

  attr_accessor :email, :password, :confirm_password

  def self.new_with_confirm(email, pass, confirm_pass)

    login = Login.new()
    login.email = email
    login.password = pass
    login.confirm_password = confirm_pass
    login
  end
end
