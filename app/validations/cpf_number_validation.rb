class CpfNumberValidation

  def validate(client)
    if client.is_number?(client.cpf)
       ""
    else
       "CPF must have numbers only"
    end
  end
end
