class AdminController < ApplicationController
  require '/home/vitor/RailsProjects/postercommerce/app/validations/auth_admin.rb'

  def index
    if session[:admin_signed_in] == true
    render 'index'
    else
      @login = Login.new()
      render 'login'
    end
  end

  def admin_log_in
    @login = Login.new(params.require(:login).permit(:email, :password))
    auth = AdminLoginAuth.new()
    result = auth.auth(@login.email, @login.password)
    if result.class.to_s.eql? TrueClass.to_s
      session[:admin_signed_in] = true
      redirect_to controller: 'admin', action: 'index'
    else
      @login.errors.add("Errors: ", result)
      render 'login'
    end
  end

  def admin_log_out
    session[:admin_signed_in] = false
    redirect_to controller: 'admin', action: 'index'
  end
end
