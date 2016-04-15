class ConfirmPasswordValidation

  def validate(client)
    if client.password.eql? client.confirm_password
      ""
    else
      "Passwords don't match"
    end
  end

end
