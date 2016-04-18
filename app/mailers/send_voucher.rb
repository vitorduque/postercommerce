class SendVoucher < ApplicationMailer
  default :from => 'no-reply@postercommerce.com'
  def send_voucher_email(client, order, voucher)
  @client = client
  @order = order
  @voucher = voucher
  mail( :to => @client.email,
  :subject => "Your voucher!" )
end
end
