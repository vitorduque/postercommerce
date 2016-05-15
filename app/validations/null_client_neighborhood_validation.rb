class NullClientNeighborhood

  def validate(client)
    if client.address.neighborhood.length == 0
       "You must live in a neighbor"
    else
       ""
    end
  end

end
