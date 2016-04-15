class NullClientZipCode

  def validate(client)
    if client.zip_code.length == 0
      "Your street must have a zip code"
    else
      ""
    end
  end

end
