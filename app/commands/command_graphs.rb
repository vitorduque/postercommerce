class CommandGraph

  def execute(domain, option)
    Facade.new().graphs(domain, option)
  end

end
