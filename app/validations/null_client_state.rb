class NullClientState

  def validate(client)
    if client.address.state.length == 0
       "You must live in a state"
    else
       ""
    end
  end

end
