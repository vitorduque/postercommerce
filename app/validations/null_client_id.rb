class NullClientId
  def validate(client)
    if client.id.length == 0
      "No id reached"
    else
      ""
    end
  end

end
