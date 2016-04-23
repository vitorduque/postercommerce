class CommandGetLastOrderById

  def execute(domain)
    Facade.new().get_last_order_by_id(domain)
  end

end
