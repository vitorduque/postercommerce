class Address
  include ActiveModel::Model
  attr_accessor :complement, :number, :street, :neighborhood, :city, :state, :zip_code

  def initialize(complement, number, street, neighborhood, city, state, zip_code)
    @complement = complement
    @number = number
    @street = street
    @neighborhood = neighborhood
    @city = city
    @state = state
    @zip_code = zip_code
  end
end
