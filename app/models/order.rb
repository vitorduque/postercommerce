class Order < Domain
  include ActiveModel::Model

  attr_accessor :total_price, :payment_method, :client_id, :shipping_method, :id, :payment_status, :shipping_status, :date

end
