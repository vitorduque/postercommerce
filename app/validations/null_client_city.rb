class NullClientCity

  def validate(client)
    if client.city.length == 0
      "You must live in a city"
    else
      ""
    end
  end

end
