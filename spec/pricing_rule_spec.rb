require 'pricing_rule'
require 'product'

RSpec.describe PricingRule do
  describe "#pricing_adjustment" do
    it "doesn't apply any discount if the bundle does not exist in items" do
      pricing_rule = PricingRule.new(50, { "sku" => 1 })
      expect(pricing_rule.pricing_adjustment([])).to eq 0
    end

    it "applies the discount if the bundle exists in items" do
      items = [Product.new(sku: "sku", name: "A Product", price: "100.23")]
      pricing_rule = PricingRule.new(50, { "sku" => 1 })

      expect(pricing_rule.pricing_adjustment(items)).to eq 50
    end

    it "applies the discount if the bundle exists in items and meets the threshold" do
      product = Product.new(sku: "sku", name: "A Product", price: "100.23")
      items = Array.new(3) { product }
      pricing_rule = PricingRule.new(50, { "sku" => 1 }, { "sku" => 3 })

      expect(pricing_rule.pricing_adjustment(items)).to eq 150
    end

    it "does not apply the discount if the bundle exists in items but does not meet the threshold" do
      product = Product.new(sku: "sku", name: "A Product", price: "100.23")
      items = Array.new(2) { product }
      pricing_rule = PricingRule.new(50, { "sku" => 1 }, { "sku" => 3 })

      expect(pricing_rule.pricing_adjustment(items)).to eq 0
    end

    it "applies the discount if the bundle has more than one item and exists in items" do
      product = Product.new(sku: "sku", name: "A Product", price: "100.23")
      other_product = Product.new(sku: "sk2", name: "A Product", price: "100.23")
      items = [product, other_product, other_product]

      pricing_rule = PricingRule.new(90, { "sku" => 1, "sk2" => 2 })

      expect(pricing_rule.pricing_adjustment(items)).to eq 90
    end

    it "applies the discount multiple times if the bundle exists in items multiple times" do
      product = Product.new(sku: "sku", name: "A Product", price: "100.23")
      other_product = Product.new(sku: "sk2", name: "A Product", price: "100.23")
      items = [product, other_product, other_product, product, other_product, other_product]

      pricing_rule = PricingRule.new(90, { "sku" => 1, "sk2" => 2 })

      expect(pricing_rule.pricing_adjustment(items)).to eq 180
    end
  end
end
