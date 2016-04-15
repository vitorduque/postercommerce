class Domain
  include ActiveModel::Model

  attr_accessor :id, :created_at, :updated_at

  def is_number?(rola)
    true if Float(rola) rescue false
  end
end
