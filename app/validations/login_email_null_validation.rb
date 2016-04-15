class LoginNullEmail

  def validate(login)
    if login.email.length == 0
      "Type your email"
    else
      ""
    end

  end

end
