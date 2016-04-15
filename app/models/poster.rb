class Poster < Domain
  include ActiveModel::Model

  #id, created_at, updated_at herdando de domain
  attr_accessor :name, :small, :medium, :large, :price_small, :price_medium, :price_large, :category, :active, :image


end
