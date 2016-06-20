class PosterObject < Domain

  include ActiveModel::Model

  #id, created_at, updated_at herdando de domain
  attr_accessor :name, :small, :medium, :large, :price_small, :price_medium, :price_large, :category, :active, :image, :q


  def initialize(id, name, small, medium, large, price_small, price_medium, price_large, category, active, image, q)
    @id = id
    @name = name
    @small = small
    @medium = medium
    @large = large
    @price_small = price_small
    @price_medium = price_medium
    @price_large = price_large
    @category = category
    @active = active
    @image = image
    @q = q
  end

end
