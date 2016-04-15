class EmailPresenceValidation

  def validate(client)
    if client.email.length == 0
      "You must have an email"
    else
      ""
    end
  end
end
