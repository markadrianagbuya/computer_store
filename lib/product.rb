class Product
  attr_accessor :sku, :name, :price

  def initialize(sku:, name:, price:)
    self.sku = sku
    self.name = name
    self.price = price
  end

  ALL_PRODUCTS = [
    Product.new(sku: "ipd", name: "Super iPad", price: 549.99),
    Product.new(sku: "mbp", name: "MacBook Pro", price: 1399.99),
    Product.new(sku: "atv", name: "Apple TV", price: 109.50),
    Product.new(sku: "vga", name: "VGA adapter", price: 30)
  ]

  def self.find_by_sku(sku)
    ALL_PRODUCTS.detect { |product| product.sku == sku }
  end
end
