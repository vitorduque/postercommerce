class CommandCancelOrderById

  def execute(domain)
    Facade.new().cancel_order_by_id(domain)
  end

end
