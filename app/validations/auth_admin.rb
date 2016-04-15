class AdminLoginAuth

  def auth(user_admin, pass_admin)
    if user_admin.eql? "admin@admin"
      if pass_admin.eql? "admin"
        true
      else
        "Invalid password"
      end
    else
        "Invalid login"
    end
  end
end
