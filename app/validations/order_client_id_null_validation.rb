class NullOrderClientId
  def validate(order)
    if order.client_id.nil?
      "No id reached"
    else
      ""
    end
  end

end
