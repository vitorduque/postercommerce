class CommandDelete

  def execute(domain)
    Facade.new().delete(domain)
  end

end
