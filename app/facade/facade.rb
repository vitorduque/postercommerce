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

  def initialize
    dao_conn_data = DaoConnectionData.new()
    @dao = Hash.new
    @dao[Poster.to_s] = PosterDao.new(OpenConnection.new(dao_conn_data.host, dao_conn_data.user,dao_conn_data.password,dao_conn_data.port,dao_conn_data.database_name))
    @dao[Client.to_s] = ClientDao.new(OpenConnection.new(dao_conn_data.host, dao_conn_data.user,dao_conn_data.password,dao_conn_data.port,dao_conn_data.database_name))
    @dao[Login.to_s] = LoginDao.new(OpenConnection.new(dao_conn_data.host, dao_conn_data.user,dao_conn_data.password,dao_conn_data.port,dao_conn_data.database_name))
    @dao[Order.to_s] = OrderDao.new(OpenConnection.new(dao_conn_data.host, dao_conn_data.user,dao_conn_data.password,dao_conn_data.port,dao_conn_data.database_name))
    @dao[Voucher.to_s] = VoucherDao.new(OpenConnection.new(dao_conn_data.host, dao_conn_data.user,dao_conn_data.password,dao_conn_data.port,dao_conn_data.database_name))

    @strategy = Hash.new()

    @strategy[Poster.to_s] = Hash.new()
    @strategy[Client.to_s] = Hash.new()
    @strategy[Login.to_s] = Hash.new()
    @strategy[Order.to_s] = Hash.new()
    @strategy[Voucher.to_s] = Hash.new()

    @strategy[Poster.to_s]['create'] = Array.new()
    @strategy[Poster.to_s]['create'][0] = NullPosterName.new
    @strategy[Poster.to_s]['create'][1] = PriceSmallPoster.new
    @strategy[Poster.to_s]['create'][2] = PriceMediumPoster.new
    @strategy[Poster.to_s]['create'][3] = PriceLargePoster.new
    @strategy[Poster.to_s]['create'][4] = SmallPriceNumValidation.new
    @strategy[Poster.to_s]['create'][5] = MediumPriceNumValidation.new
    @strategy[Poster.to_s]['create'][6] = LargePriceNumValidation.new
    @strategy[Poster.to_s]['create'][7] = ImagePresenceValidation.new
    @strategy[Poster.to_s]['create'][8] = PhotoExtensionValidation.new

    @strategy[Poster.to_s]['edit'] = Array.new()
    @strategy[Poster.to_s]['edit'][0] = IDPosterValidation.new
    @strategy[Poster.to_s]['edit'][1] = NullPosterName.new
    @strategy[Poster.to_s]['edit'][2] = PriceSmallPoster.new
    @strategy[Poster.to_s]['edit'][3] = PriceMediumPoster.new
    @strategy[Poster.to_s]['edit'][4] = PriceLargePoster.new
    @strategy[Poster.to_s]['edit'][5] = SmallPriceNumValidation.new
    @strategy[Poster.to_s]['edit'][6] = MediumPriceNumValidation.new
    @strategy[Poster.to_s]['edit'][7] = LargePriceNumValidation.new
    @strategy[Poster.to_s]['edit'][8] = ImagePresenceValidation.new
    @strategy[Poster.to_s]['edit'][9] = PhotoExtensionValidation.new

    @strategy[Poster.to_s]['delete'] = Array.new()
    @strategy[Poster.to_s]['delete'][0] = IDPosterValidation.new

    @strategy[Poster.to_s]['show'] = Array.new()
    @strategy[Poster.to_s]['show'][0] = IDPosterValidation.new


    @strategy[Client.to_s]['create'] = Array.new()
    @strategy[Client.to_s]['create'][0] = NullClientName.new()
    @strategy[Client.to_s]['create'][1] = EmailPresenceValidation.new()
    @strategy[Client.to_s]['create'][2] = EmailValidation.new()
    @strategy[Client.to_s]['create'][3] = CpfLengthValidation.new()
    @strategy[Client.to_s]['create'][4] = CpfNumberValidation.new()
    @strategy[Client.to_s]['create'][5] = NullClientStreet.new()
    @strategy[Client.to_s]['create'][6] = NullClientNeighborhood.new()
    @strategy[Client.to_s]['create'][7] = NullClientNumber.new()
    @strategy[Client.to_s]['create'][8] = ClientNumberValidation.new()
    @strategy[Client.to_s]['create'][9] = ExistingEmailValidation.new()
    @strategy[Client.to_s]['create'][10] = ExistingCpfValidation.new()
    @strategy[Client.to_s]['create'][11] = NullClientCity.new()
    @strategy[Client.to_s]['create'][12] = NullClientState.new()
    @strategy[Client.to_s]['create'][13] = NullClientZipCode.new()
    @strategy[Client.to_s]['create'][14] = PasswordLengthValidation.new()
    @strategy[Client.to_s]['create'][15] = ConfirmPasswordValidation.new()


    @strategy[Client.to_s]['show'] = Array.new()
    @strategy[Client.to_s]['show'][0] = NullClientId.new

    @strategy[Client.to_s]['edit'] = Array.new()
    @strategy[Client.to_s]['edit'][0] = NullClientStreet.new()
    @strategy[Client.to_s]['edit'][1] = NullClientNeighborhood.new()
    @strategy[Client.to_s]['edit'][2] = NullClientNumber.new()
    @strategy[Client.to_s]['edit'][3] = NullClientCity.new()
    @strategy[Client.to_s]['edit'][4] = NullClientState.new()
    @strategy[Client.to_s]['edit'][5] = NullClientZipCode.new()

    @strategy[Login.to_s]['find_by_email'] = Array.new()
    @strategy[Login.to_s]['find_by_email'][0] = LoginNullPassword.new()
    @strategy[Login.to_s]['find_by_email'][1] = LoginNullEmail.new()
    @strategy[Login.to_s]['find_by_email'][2] = EmailValidation.new()


    @strategy[Order.to_s]['create'] = Array.new()
    @strategy[Order.to_s]['create'][0] = NullShippingMethod.new()
    @strategy[Order.to_s]['create'][1] = NullPaymentMethod.new()
    @strategy[Order.to_s]['create'][2] = VoucherActive.new()

    @strategy[Order.to_s]['list'] = Array.new()

    @strategy[Order.to_s]['show'] = Array.new()
    @strategy[Order.to_s]['show'][0] = GenericNullValidation.new()

    @strategy[Order.to_s]['set'] = Array.new
    @strategy[Order.to_s]['show'][0] = GenericNullValidation.new()

    @strategy[Voucher.to_s]['show'] = Array.new()
    @strategy[Voucher.to_s]['show'][0] = VoucherNullValidation.new()


    @strategy[Voucher.to_s]['edit'] = Array.new()
    @strategy[Voucher.to_s]['edit'][0] = VoucherNullValidation.new()

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


private
  def voucher_gen
    SecureRandom.uuid
  end

end
