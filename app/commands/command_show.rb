class CommandShow

  def execute(domain)
    Facade.new().find(domain)
  end

end
