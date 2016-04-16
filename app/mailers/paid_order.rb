class PaidOrder < ApplicationMailer
  default :from => 'no-reply@postercommerce.com'

  def send_paid_email(order, client)
  @client = client
  @order = order
  mail( :to => @client.email,
  :subject => "Your payment's order ##{order.id} status was changed!" )
end


end
