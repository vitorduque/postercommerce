class NullOrderId
  def validate(order)
    if order.id.nil?
      "No id reached"
    else
      ""
    end
  end

end
