require 'checkout'
require 'product'

RSpec.describe Checkout do
  describe "#total" do
    it "returns 0 if there are no items scanned" do
      expect(Checkout.new.total).to eq 0
    end

    it "returns the price of the item if there is one item scanned" do
      item_1 = Product.new(sku: 'sku', name: 'A Product', price: 4.99)
      checkout = Checkout.new
      checkout.scan(item_1)
      expect(checkout.total).to eq 4.99
    end
  end
end
