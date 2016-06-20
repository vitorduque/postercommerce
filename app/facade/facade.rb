class Facade
  require '/home/vitor/RailsProjects/postercommerce/app/validations/null_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/small_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/medium_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/large_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/presence_small_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/presence_medium_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/presence_large_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/presence_image_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/photo_extension_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/id_poster_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/null_client_name_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/presence_email_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/email_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/cpf_length_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/cpf_length_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/null_client_street_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/null_client_neighborhood_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/null_client_number_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/client_number_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/login_password_null_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/login_email_null_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/null_shipping_method_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/null_payment_method_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/existing_email_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/existing_cpf_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/null_client_city.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/null_client_state.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/null_client_zipcode.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/password_length_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/null_client_id.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/models/dao_connection_datas.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/generic_null_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/voucher_active_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/order_client_id_null_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/null_order_id_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/client_image_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/client_gender_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/graph_date.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/graph_return.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/validations/born_date_validation.rb'
  require '/home/vitor/RailsProjects/postercommerce/app/dao/order_item_dao.rb'

  def initialize
    dao_conn_data = DaoConnectionData.new()
    @dao = Hash.new
    @dao[Poster.to_s] = PosterDao.new(OpenConnection.new(dao_conn_data.host, dao_conn_data.user,dao_conn_data.password,dao_conn_data.port,dao_conn_data.database_name))
    @dao[Client.to_s] = ClientDao.new(OpenConnection.new(dao_conn_data.host, dao_conn_data.user,dao_conn_data.password,dao_conn_data.port,dao_conn_data.database_name))
    @dao[Login.to_s] = LoginDao.new(OpenConnection.new(dao_conn_data.host, dao_conn_data.user,dao_conn_data.password,dao_conn_data.port,dao_conn_data.database_name))
    @dao[Order.to_s] = OrderDao.new(OpenConnection.new(dao_conn_data.host, dao_conn_data.user,dao_conn_data.password,dao_conn_data.port,dao_conn_data.database_name))
    @dao[Voucher.to_s] = VoucherDao.new(OpenConnection.new(dao_conn_data.host, dao_conn_data.user,dao_conn_data.password,dao_conn_data.port,dao_conn_data.database_name))
    @dao[Graph.to_s] = GraphDao.new(OpenConnection.new(dao_conn_data.host, dao_conn_data.user,dao_conn_data.password,dao_conn_data.port,dao_conn_data.database_name))
    @dao[Cart.to_s] =  ItemDao.new(OpenConnection.new(dao_conn_data.host, dao_conn_data.user,dao_conn_data.password,dao_conn_data.port,dao_conn_data.database_name))

    #Objects
    @dao[ClientObject.to_s] = ClientDao.new(OpenConnection.new(dao_conn_data.host, dao_conn_data.user,dao_conn_data.password,dao_conn_data.port,dao_conn_data.database_name))
    @dao[PosterObject.to_s] = PosterDao.new(OpenConnection.new(dao_conn_data.host, dao_conn_data.user,dao_conn_data.password,dao_conn_data.port,dao_conn_data.database_name))

    @strategy = Hash.new

    @strategy[Poster.to_s] = Hash.new
    @strategy[Client.to_s] = Hash.new
    @strategy[Login.to_s] = Hash.new
    @strategy[Order.to_s] = Hash.new
    @strategy[Voucher.to_s] = Hash.new
    @strategy[Graph.to_s] = Hash.new
    @strategy[Cart.to_s] = Hash.new

    @strategy[ClientObject.to_s] = Hash.new
    @strategy[PosterObject.to_s] = Hash.new

    @strategy[PosterObject.to_s]['create'] = Array.new
    @strategy[PosterObject.to_s]['create'][0] = PhotoExtensionValidation.new
    @strategy[PosterObject.to_s]['create'][1] = NullPosterName.new
    @strategy[PosterObject.to_s]['create'][2] = PriceSmallPoster.new
    @strategy[PosterObject.to_s]['create'][3] = PriceMediumPoster.new
    @strategy[PosterObject.to_s]['create'][4] = PriceLargePoster.new
    @strategy[PosterObject.to_s]['create'][5] = SmallPriceNumValidation.new
    @strategy[PosterObject.to_s]['create'][6] = MediumPriceNumValidation.new
    @strategy[PosterObject.to_s]['create'][7] = LargePriceNumValidation.new
    @strategy[PosterObject.to_s]['create'][8] = ImagePresenceValidation.new
    @strategy[PosterObject.to_s]['create'][9] = ClientImageValidation.new


    @strategy[PosterObject.to_s]['edit'] = Array.new()
    @strategy[PosterObject.to_s]['edit'][0] = PhotoExtensionValidation.new
    @strategy[PosterObject.to_s]['edit'][1] = NullPosterName.new
    @strategy[PosterObject.to_s]['edit'][2] = PriceSmallPoster.new
    @strategy[PosterObject.to_s]['edit'][3] = PriceMediumPoster.new
    @strategy[PosterObject.to_s]['edit'][4] = PriceLargePoster.new
    @strategy[PosterObject.to_s]['edit'][5] = SmallPriceNumValidation.new
    @strategy[PosterObject.to_s]['edit'][6] = MediumPriceNumValidation.new
    @strategy[PosterObject.to_s]['edit'][7] = LargePriceNumValidation.new
    @strategy[PosterObject.to_s]['edit'][8] = ImagePresenceValidation.new
    @strategy[PosterObject.to_s]['edit'][9] = IDPosterValidation.new
    @strategy[PosterObject.to_s]['edit'][9] = ClientImageValidation.new

    @strategy[PosterObject.to_s]['delete'] = Array.new()
    @strategy[PosterObject.to_s]['delete'][0] = IDPosterValidation.new

    @strategy[PosterObject.to_s]['show'] = Array.new()
    @strategy[PosterObject.to_s]['show'][0] = IDPosterValidation.new


    @strategy[ClientObject.to_s]['create'] = Array.new()
    @strategy[ClientObject.to_s]['create'][0] = ClientGenderValidation.new()
    @strategy[ClientObject.to_s]['create'][1] = EmailPresenceValidation.new()
    @strategy[ClientObject.to_s]['create'][2] = EmailValidation.new()
    @strategy[ClientObject.to_s]['create'][3] = CpfLengthValidation.new()
    @strategy[ClientObject.to_s]['create'][4] = CpfNumberValidation.new()
    @strategy[ClientObject.to_s]['create'][5] = NullClientStreet.new()
    @strategy[ClientObject.to_s]['create'][6] = NullClientNeighborhood.new()
    @strategy[ClientObject.to_s]['create'][7] = NullClientNumber.new()
    @strategy[ClientObject.to_s]['create'][8] = ClientNumberValidation.new()
    @strategy[ClientObject.to_s]['create'][9] = ExistingEmailValidation.new()#
    @strategy[ClientObject.to_s]['create'][10] = ExistingCpfValidation.new()#
    @strategy[ClientObject.to_s]['create'][11] = NullClientCity.new()
    @strategy[ClientObject.to_s]['create'][12] = NullClientState.new()
    @strategy[ClientObject.to_s]['create'][13] = NullClientZipCode.new()
    @strategy[ClientObject.to_s]['create'][14] = PasswordLengthValidation.new()
    @strategy[ClientObject.to_s]['create'][15] = ConfirmPasswordValidation.new()
    @strategy[ClientObject.to_s]['create'][16] = NullClientName.new
    @strategy[ClientObject.to_s]['create'][17] = BornDateValidation.new

    @strategy[Client.to_s]['show'] = Array.new()
    @strategy[Client.to_s]['show'][0] = NullClientId.new

    @strategy[ClientObject.to_s]['edit'] = Array.new()
    @strategy[ClientObject.to_s]['edit'][0] = NullClientStreet.new()
    @strategy[ClientObject.to_s]['edit'][1] = NullClientNeighborhood.new()
    @strategy[ClientObject.to_s]['edit'][2] = NullClientNumber.new()
    @strategy[ClientObject.to_s]['edit'][3] = NullClientCity.new()
    @strategy[ClientObject.to_s]['edit'][4] = NullClientState.new()
    @strategy[ClientObject.to_s]['edit'][5] = NullClientZipCode.new()
    @strategy[ClientObject.to_s]['edit'][6] = ClientNumberValidation.new()

    @strategy[Login.to_s]['find_by_email'] = Array.new()
    @strategy[Login.to_s]['find_by_email'][0] = LoginNullPassword.new()
    @strategy[Login.to_s]['find_by_email'][1] = LoginNullEmail.new()
    #@strategy[Login.to_s]['find_by_email'][2] = EmailValidation.new()


    @strategy[Order.to_s]['create'] = Array.new()
    @strategy[Order.to_s]['create'][0] = NullShippingMethod.new()
    @strategy[Order.to_s]['create'][1] = NullPaymentMethod.new()
    @strategy[Order.to_s]['create'][2] = VoucherActive.new()

    @strategy[Order.to_s]['list'] = Array.new()

    @strategy[Order.to_s]['show'] = Array.new()
    @strategy[Order.to_s]['show'][0] = GenericNullValidation.new()

    @strategy[Order.to_s]['set'] = Array.new
    @strategy[Order.to_s]['show'][0] = GenericNullValidation.new()

    @strategy[Order.to_s]['get_orders_by_id'] = Array.new
    @strategy[Order.to_s]['get_orders_by_id'][0] = NullOrderClientId.new

    @strategy[Order.to_s]['get_last_order_by_id'] = Array.new
    @strategy[Order.to_s]['get_last_order_by_id'][0] = NullOrderClientId.new

    @strategy[Order.to_s]['complain_order_by_id'] = Array.new
    @strategy[Order.to_s]['complain_order_by_id'][0] = NullOrderId.new

    @strategy[Order.to_s]['cancel_order_by_id'] = Array.new
    @strategy[Order.to_s]['cancel_order_by_id'][0] = NullOrderId.new

    @strategy[Voucher.to_s]['show'] = Array.new
    @strategy[Voucher.to_s]['show'][0] = VoucherNullValidation.new

    @strategy[Voucher.to_s]['retrieve_clients_active_vouchers'] = Array.new



    @strategy[Voucher.to_s]['edit'] = Array.new
    @strategy[Voucher.to_s]['edit'][0] = VoucherNullValidation.new

    @strategy[Graph.to_s]['graph'] = Array.new()
    @strategy[Graph.to_s]['graph'][0] = GraphDateValidation.new
    @strategy[Graph.to_s]['graph'][1] = GraphReturnValidation.new

    @strategy[Cart.to_s]['create'] = Array.new
    @strategy[Cart.to_s]['show'] = Array.new

    @strategyResult = ""
  end

  def list(domain)
    something = @dao[domain.class.to_s].list
    something
  end

  def edit(domain)
    @strategy[domain.class.to_s]['edit'].each do |t|
      teste = t.validate(domain)
      if teste.length != 0
        @strategyResult = @strategyResult + teste
      end
    end

    if @strategyResult.length == 0
      @dao[domain.class.to_s].edit(domain)
    else
      return @strategyResult
    end
  end

  def delete(domain)
    @strategy[domain.class.to_s]['delete'].each do |t|
      teste = t.validate(domain)
      if teste.length != 0
        @strategyResult = @strategyResult + teste
      end
    end

    if @strategyResult.length == 0
      @dao[domain.class.to_s].delete(domain.id)
    else
      @strategyResult
    end
  end

  def find(domain)
    @strategy[domain.class.to_s]['show'].each do |t|
      teste = t.validate(domain)
      if teste.length != 0
        @strategyResult = @strategyResult + teste
      end
    end

    if @strategyResult.length == 0
      if domain.class.to_s.eql? "Voucher"
        @dao[domain.class.to_s].find(domain.id_voucher)
      elsif domain.class.to_s.eql? "Cart"
        @dao[domain.class.to_s].find(domain)
      else
        @dao[domain.class.to_s].find(domain.id)
      end
    else
      @strategyResult
    end
  end

  def create (domain)
    @strategy[domain.class.to_s]['create'].each do |t|
      teste = t.validate(domain)
      if teste.length != 0
        @strategyResult = @strategyResult + " " + teste
      end
    end

    if @strategyResult.length == 0
      @dao[domain.class.to_s].create(domain)
    else
      return @strategyResult
    end
  end

  def find_by_email(domain)

    @strategy[domain.class.to_s]['find_by_email'].each do |t|
      teste = t.validate(domain)
      if teste.length != 0
        @strategyResult = @strategyResult + " " + teste
      end
    end

    if @strategyResult.length == 0
      @dao[domain.class.to_s].find_by_email(domain.email)
    else
      return @strategyResult
    end

  end

  def set(domain, client)
    @strategy[domain.class.to_s]['set'].each do |t|
      teste = t.validate(domain)
      if teste.length != 0
        @strategyResult = @strategyResult + " " + teste
      end
    end

    #Basicaly verify if the order was paid or not
    if @strategyResult.length == 0
      if domain.payment_status.eql? "Waiting payment"
        PaidOrder.send_paid_email(domain, client).deliver
        @dao[domain.class.to_s].set_as_paid(domain)
      elsif domain.payment_status.eql? "Paid"
        @dao[domain.class.to_s].set_as_delivered(domain)
        DeliveryOrder.send_delivery_email(domain, client).deliver
      elsif domain.payment_status.eql? "COMPLAINED"
        voucher = voucher_gen

        @dao[Voucher.to_s].create(voucher, domain)
        @dao[domain.class.to_s].set_voucher_sent(domain)
        SendVoucher.send_voucher_email(client, domain, voucher).deliver
      end
    else
      return @strategyResult
    end

  end


  def get_orders_by_id(domain)
    @strategy[domain.class.to_s]['get_orders_by_id'].each do |t|
      teste = t.validate(domain)
      if teste.length != 0
        @strategyResult = @strategyResult + " " + teste
      end
    end
    if @strategyResult.length == 0
      @dao[domain.class.to_s].get_orders(domain.client_id)
    else
      return @strategyResult
    end
  end

  def get_last_order_by_id(domain)
    @strategy[domain.class.to_s]['get_last_order_by_id'].each do |t|
      teste = t.validate(domain)
      if teste.length != 0
        @strategyResult = @strategyResult + " " + teste
      end
    end
    if @strategyResult.length == 0
      @dao[domain.class.to_s].get_last_order(domain.client_id)
    else
      return @strategyResult
    end

  end

  def complain_order_by_id(domain)
    @strategy[domain.class.to_s]['complain_order_by_id'].each do |t|
      teste = t.validate(domain)
      if teste.length != 0
        @strategyResult = @strategyResult + " " + teste
      end
    end

    if @strategyResult.length == 0
      @dao[domain.class.to_s].set_as_complained(domain)
    else
      return @strategyResult
    end
  end

  def cancel_order_by_id(domain)
    @strategy[domain.class.to_s]['cancel_order_by_id'].each do |t|
      teste = t.validate(domain)
      if teste.length != 0
        @strategyResult = @strategyResult + " " + teste
      end
    end

    if @strategyResult.length == 0
      @dao[domain.class.to_s].cancel_order(domain.id)
    else
      return @strategyResult
    end

  end


  def graphs(domain, option)
    @strategy[domain.class.to_s]['graph'].each do |t|
      teste = t.validate(domain)
      if teste.length != 0
        @strategyResult = @strategyResult + " " + teste
      end
    end

    if @strategyResult.length == 0
      @dao[domain.class.to_s].retrieve_data(domain, option)
    else
      return @strategyResult
    end

  end

  def retrieve_clients_active_vouchers(domain)
    @strategy[domain.class.to_s]['retrieve_clients_active_vouchers'].each do |t|
      teste = t.validate(domain)
      if teste.length != 0
        @strategyResult = @strategyResult + " " + teste
      end
    end

    if @strategyResult.length == 0
      @dao[domain.class.to_s].retrieve_clients_active_vouchers(domain)
    else
      return @strategyResult
    end

  end

private
  def voucher_gen
    SecureRandom.uuid
  end

end
