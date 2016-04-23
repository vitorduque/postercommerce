class CommandGetOrdersById

  def execute(domain)
    Facade.new().get_orders_by_id(domain)
  end

end
