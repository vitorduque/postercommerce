class Category
  include ActiveModel::Model
  attr_accessor :category

  def initialize(category)
    @category = category
  end

end
