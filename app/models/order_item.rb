class OrderItem
  include ActiveModel::Model

  attr_accessor :orders_id, :orders_clients_id, :posters_id, :size, :amount, :name, :price_small, :price_medium, :price_large, :small, :medium, :large

end
