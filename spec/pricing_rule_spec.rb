require 'pricing_rule'
require 'product'

RSpec.describe PricingRule do
  context "ThreeForTwoAppleTVs" do
    describe "#pricing_adjustment" do
      it "is minus the price of an apple tv if there are 3 apple tvs scanned" do
        apple_tv = Product.find_by_sku("atv")
        three_apple_tvs = Array.new(3) { apple_tv }

        pricing_rule = PricingRule::ThreeForTwoAppleTVs.new
        expect(pricing_rule.pricing_adjustment(three_apple_tvs)).to eq apple_tv.price
      end

      it "is zero if there aren't enough apple_tvs" do
        apple_tv = Product.find_by_sku("atv")
        three_apple_tvs = Array.new(2) { apple_tv }

        pricing_rule = PricingRule::ThreeForTwoAppleTVs.new
        expect(pricing_rule.pricing_adjustment(three_apple_tvs)).to eq 0
      end

      it "applies the pricing adjustment twice if there are two bundles" do
        apple_tv = Product.find_by_sku("atv")
        three_apple_tvs = Array.new(7) { apple_tv }

        pricing_rule = PricingRule::ThreeForTwoAppleTVs.new
        expect(pricing_rule.pricing_adjustment(three_apple_tvs)).to eq apple_tv.price * 2
      end
    end
  end
end
