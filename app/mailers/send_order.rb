class SendOrder < ApplicationMailer
  default :from => 'no-reply@postercommerce.com'

  def send_order_email(client, order, items)
  @client = client
  @order = order
  @items = items
  
  mail( :to => @client.email,
  :subject => "New order was registred in our database" )
end

end
