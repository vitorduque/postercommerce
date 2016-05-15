class PasswordLengthValidation

  def validate(client)
    if client.login.password.length < 6
       "Password must have at least 6 digits"
    else
       ""
    end
  end

end
