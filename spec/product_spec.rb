require 'product'

RSpec.describe Product do
  describe "#sku" do
    it "returns the sku" do
      product = Product.new(sku: 'sku', name: 'A Product', price: 1.25)
      expect(product.sku).to eq 'sku'
    end
  end

  describe "#name" do
    it "returns the name" do
      product = Product.new(sku: 'sku', name: 'A Product', price: 1.25)
      expect(product.name).to eq 'A Product'
    end
  end

  describe "#price" do
    it "returns the price" do
      product = Product.new(sku: 'sku', name: 'A Product', price: 1.25)
      expect(product.price).to eq 1.25
    end
  end
end
