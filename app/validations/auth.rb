class LoginAuth

  def auth(user_pass, login_pass)
    if user_pass.eql? login_pass
      true
    else
      "Invalid Password"

    end
    
  end

end
