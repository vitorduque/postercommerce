class CommandSet

  def execute(order, client)
    Facade.new().set(order, client)
  end

end
