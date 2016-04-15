class CommandFindByEmail

  def execute(domain)
    Facade.new().find_by_email(domain)
  end

end
