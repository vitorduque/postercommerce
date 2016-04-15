class DeliveryOrder < ApplicationMailer

  default :from => 'no-reply@postercommerce.com'

  def send_delivery_email(order, client)

  @client = client
  @order = order
  binding.pry
  mail( :to => @client.email,
  :subject => "Your delivery order ##{order.id} was changed!" )
end

end
