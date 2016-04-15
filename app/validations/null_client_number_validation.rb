class NullClientNumber

  def validate(client)
    if client.number.length == 0
       "Your house must have a number"
    else
       ""
    end
  end

end
