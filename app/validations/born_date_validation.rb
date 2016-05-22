class BornDateValidation

  def validate(client)

    if client.born_date.blank?
      "Select your born date"
    else
      ""
    end

  end


end
