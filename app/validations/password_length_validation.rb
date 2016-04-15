class PasswordLengthValidation

  def validate(client)
    if client.password.length < 6
       "Password must have at least 6 digits"
    else
       ""
    end
  end

end
