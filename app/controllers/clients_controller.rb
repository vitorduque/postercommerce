class ClientsController < ApplicationController

  def new
    @client = Client.new()
  end

  def create
    @client = Client.new(params.require(:client).permit(:id, :name, :email, :password,:cpf, :street, :number, :neighborhood, :city, :state, :zip_code, :complement, :confirm_password))

    result = @command['create'].execute(@client)

    if result.nil?
      redirect_to controller: 'store', action: 'index'
    else
      @client.errors.add("Errors: ", result)
      render 'new'
    end
  end

  def edit
    @client = @command['show'].execute(Client.new(id: params[:id]))
    if @client.id.nil?
      redirect_to controller: 'cart', action: 'index', notice: 'Error: No ID reached out'
    end
    if !@client.id.eql? session[:user_id]
      redirect_to controller: 'cart', action: 'index', notice: 'Error: No ID reached out'
    end
  end

  def update
    @client = Client.new(params.require(:client).permit(:id, :street, :number, :neighborhood, :city, :state, :zip_code, :complement))
    result = @command['edit'].execute(@client)
    if result.nil?
      redirect_to controller: 'cart', action: 'index'
    else
      @client.errors.add("Errors: ", result)
      render 'edit'
    end
  end

end
