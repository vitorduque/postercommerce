class ClientImageValidation

  def validate(client)

    if client.image.nil?
      "Select and image"
    else
      ""
    end      
  end

end
