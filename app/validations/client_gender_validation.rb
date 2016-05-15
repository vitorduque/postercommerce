class ClientGenderValidation

  def validate(client)
    if client.gender.nil?
       "You must select a gender"
    else
       ""
    end
  end

end
