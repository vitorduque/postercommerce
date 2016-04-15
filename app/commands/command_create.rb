class CommandCreate

  def execute(domain)
    Facade.new().create(domain)
  end

end
