class Voucher
  include ActiveModel::Model

  attr_accessor :id_voucher, :price, :active, :clients_id

end
