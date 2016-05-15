class ClientNumberValidation

  def validate(client)

    if client.is_number?(client.address.number)
      ""
    else
      "Your house's number must have numbers only"
    end
  end
end
