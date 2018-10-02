class Product
  attr_accessor :sku, :name, :price

  def initialize(sku:, name:, price:)
    self.sku = sku
    self.name = name
    self.price = price
  end
end
