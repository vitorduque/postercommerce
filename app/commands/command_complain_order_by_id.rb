class CommandComplainOrderById

  def execute(domain)
    Facade.new().complain_order_by_id(domain)
  end

end
