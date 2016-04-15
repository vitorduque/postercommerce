class NullPaymentMethod

  def validate(order)
    if order.payment_method.nil?
       "You must select an payment method"
    else
       ""
    end
  end
end
