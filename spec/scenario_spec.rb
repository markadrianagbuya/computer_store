require 'specials'
require 'checkout'

RSpec.describe "Computer Store Scenarios" do
  describe "Example Scenario 1" do
    it "calculates total correctly" do
      pricing_rules = Specials.all_pricing_rules
      skus_scanned = %w[atv atv atv vga]
      items = items(skus_scanned)

      checkout = Checkout.new(pricing_rules)
      items.each { |item| checkout.scan(item) }

      expect(checkout.total).to eq 249
    end
  end

  describe "Example Scenario 2" do
    it "calculates total correctly" do
      pricing_rules = Specials.all_pricing_rules
      skus_scanned = %w[atv ipd ipd atv ipd ipd ipd]
      items = items(skus_scanned)

      checkout = Checkout.new(pricing_rules)
      items.each { |item| checkout.scan(item) }

      expect(checkout.total).to eq 2718.95
    end
  end

  describe "Example Scenario 3" do
    it "calculates total correctly" do
      pricing_rules = Specials.all_pricing_rules
      skus_scanned = %w[mbp vga ipd]
      items = items(skus_scanned)

      checkout = Checkout.new(pricing_rules)
      items.each { |item| checkout.scan(item) }

      expect(checkout.total).to eq 1949.98
    end
  end

  def items(skus_scanned)
    skus_scanned.map do |sku|
      Product.find_by_sku(sku)
    end
  end
end
