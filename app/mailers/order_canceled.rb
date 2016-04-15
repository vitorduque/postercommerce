class OrderCanceled < ApplicationMailer
  default :from => 'no-reply@postercommerce.com'

  def send_canceled_email(client, order)
  @client = client
  @order = order
  mail( :to => @client.email,
  :subject => "You canceled you order #'#{order.id}'" )
end

end
