class CommandList

  def execute(domain)
    Facade.new().list(domain)
  end

end
