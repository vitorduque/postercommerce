class CommandEdit

  def execute(domain)
    Facade.new().edit(domain)
  end

end
