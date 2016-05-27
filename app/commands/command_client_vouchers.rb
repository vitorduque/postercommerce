class CommandClientActiveVouchers

  def execute(domain)
    Facade.new().retrieve_clients_active_vouchers(domain)
  end

end
