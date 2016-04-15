class NullClientNeighborhood

  def validate(client)
    if client.neighborhood.length == 0
       "You must live in a neighbor"
    else
       ""
    end
  end

end
