class NullClientName

  def validate(client)
    if client.name.length == 0
       "You must have a name"
    else
       ""
    end
  end

end
