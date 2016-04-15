class CommandSet

  def execute(order)
    Facade.new().set(order)
  end

end
