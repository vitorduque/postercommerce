class EmailValidation

  def validate(client)

    begin
      if client.login.email.include? "@"
        ""
      else
        "Email must have '@'"
      end
    rescue

    end

  end

end
