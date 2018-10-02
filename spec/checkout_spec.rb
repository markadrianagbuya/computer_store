require 'checkout'
require 'product'
require 'pricing_rule'

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

    it "returns the combined price of the items if there is more than one item scanned" do
      item_1 = Product.new(sku: 'sku', name: 'A Product', price: 4.99)
      item_2 = Product.new(sku: 'sk2', name: 'Other Product', price: 2.99)

      checkout = Checkout.new
      checkout.scan(item_1)
      checkout.scan(item_2)

      expect(checkout.total).to eq 7.98
    end

    it "applies the apple tv deal if applicable" do
      apple_tv = Product.find_by_sku("atv")
      three_apple_tvs = Array.new(3) { apple_tv }

      pricing_rule = PricingRule::ThreeForTwoAppleTVs.new
      
      checkout = Checkout.new([pricing_rule], three_apple_tvs)
      expect(checkout.total).to eq apple_tv.price * 2
    end
  end
end
