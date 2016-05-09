class ClientsController < ApplicationController

  def new
    @client = Client.new()
  end

  def create

    #client VO
    @client = Client.new(params.require(:client).permit(:id, :name, :email, :password,:cpf, :street, :number, :neighborhood, :city, :state, :zip_code, :complement, :confirm_password))

    address = Address.new(@client.complement, @client.number, @client.street, @client.neighborhood, @client.city, @client.state, @client.zip_code)
    login = Login.new_with_confirm(@client.email, @client.password, @client.confirm_password)

    #The real client object
    @client_object = ClientObject.new(@client.name, @client.cpf, login, address)


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
