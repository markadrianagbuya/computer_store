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

  describe ".find_by_sku" do
    it "returns the product that has the matching sku" do
      apple_tv_product = Product.find_by_sku("atv")
      expect(apple_tv_product.sku).to eq "atv"
      expect(apple_tv_product.name).to eq "Apple TV"
    end
  end
end
