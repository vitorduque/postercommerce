class NullShippingMethod

  def validate(order)
    if order.shipping_method.nil?
       "You must select an shipping method"
    else
       ""
    end
  end
end
