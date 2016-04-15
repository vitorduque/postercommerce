class NullClientStreet

  def validate(client)
    if client.street.length == 0
      "You must live in a street"
    else
      ""
    end
  end

end
