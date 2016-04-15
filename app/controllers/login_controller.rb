class LoginController < ApplicationController
  require '/home/vitor/RailsProjects/LES/app/validations/auth.rb'

  def index
      @login = Login.new()
      render 'login'
  end

  def log_in
    @login = Login.new(params.require(:login).permit(:email, :password))
    @user = @command['find_by_email'].execute(@login)

    if @user.class.to_s.eql? String.to_s
      @login.errors.add("Errors: ", @user)
      render 'login'

    elsif  @user.email.nil?
      @login.errors.add("Errors: ", "Invalid email")
      render 'login'

    else
      auth = LoginAuth.new()
      result = auth.auth(@user.password, @login.password)
      if result.class.to_s.eql? TrueClass.to_s
        session[:signed_in] = true
        session[:user] = @user
        session[:user_id] = @user.id
        session[:cart_signed_in] = Hash.new
        session[:cart_signed_in][@user.id] = session[:cart]

        redirect_to root_path
      else
        @login.errors.add("Errors: ", result)
        render 'login'
      end

    end

  end

  def log_out
    session[:signed_in] = false
    session[:id] = nil
    session[:cart] = Array.new
    session[:cart_signed_in] = nil
    redirect_to root_path
  end

end
