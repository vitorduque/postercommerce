class ConfirmPasswordValidation

  def validate(client)
    if client.login.password.eql? client.login.confirm_password
      ""
    else
      "Passwords don't match"
    end
  end

end
