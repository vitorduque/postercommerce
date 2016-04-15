class SendOrder < ApplicationMailer
  default :from => 'no-reply@postercommerce.com'

  def send_order_email(client, order)
  @client = client
  @order = order
  mail( :to => @client.email,
  :subject => "Your order is #'#{order.id}'" )
end

end
