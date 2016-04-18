class ComplainOrder < ApplicationMailer
  default :from => 'no-reply@postercommerce.com'
  def send_complained_email(client, order)
  @client = client
  @order = order
  mail( :to => @client.email,
  :subject => "You complained your order order ##{order.id}!" )
end

end
