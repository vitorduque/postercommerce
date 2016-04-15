class CpfLengthValidation

  def validate(client)
    if client.cpf.length < 11
       "CPF must have 11 digits "
    else
       ""
    end
  end

end
