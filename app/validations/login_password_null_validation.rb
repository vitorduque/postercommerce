class LoginNullPassword


  def validate(login)
    if login.password.length == 0
      "Type your password"
    else
      ""
    end


  end

end
