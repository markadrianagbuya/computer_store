require 'specials'
require 'product'

RSpec.describe Specials do
  context "ThreeForTwoAppleTVs" do
    describe "#pricing_adjustment" do
      it "is minus the price of an apple tv if there are 3 apple tvs scanned" do
        apple_tv = Product.find_by_sku("atv")
        three_apple_tvs = Array.new(3) { apple_tv }

        pricing_rule = Specials::ThreeForTwoAppleTVs.pricing_rule
        expect(pricing_rule.pricing_adjustment(three_apple_tvs)).to eq apple_tv.price
      end

      it "is zero if there aren't enough apple_tvs" do
        apple_tv = Product.find_by_sku("atv")
        three_apple_tvs = Array.new(2) { apple_tv }

        pricing_rule = Specials::ThreeForTwoAppleTVs.pricing_rule
        expect(pricing_rule.pricing_adjustment(three_apple_tvs)).to eq 0
      end

      it "applies the pricing adjustment twice if there are two bundles" do
        apple_tv = Product.find_by_sku("atv")
        three_apple_tvs = Array.new(7) { apple_tv }

        pricing_rule = Specials::ThreeForTwoAppleTVs.pricing_rule
        expect(pricing_rule.pricing_adjustment(three_apple_tvs)).to eq apple_tv.price * 2
      end
    end
  end

  context "FreeVGAWithMacBookPro" do
    describe "#pricing_adjustment" do
      it "is minus the price of a VGA cable if there is also a macbook pro scanned" do
        vga_cable = Product.find_by_sku("vga")
        macbook_pro = Product.find_by_sku("mbp")

        pricing_rule = Specials::FreeVGAWithMacBookPro.pricing_rule
        discount = pricing_rule.pricing_adjustment([vga_cable, macbook_pro])
        expect(discount).to eq vga_cable.price
      end

      it "doesn't apply the discount unless the vga cable is scanned" do
        macbook_pro = Product.find_by_sku("mbp")

        pricing_rule = Specials::FreeVGAWithMacBookPro.pricing_rule
        discount = pricing_rule.pricing_adjustment([macbook_pro])
        expect(discount).to eq 0
      end

      it "doesn't apply the discount unless the macbook pro is scanned" do
        vga_cable = Product.find_by_sku("vga")

        pricing_rule = Specials::FreeVGAWithMacBookPro.pricing_rule
        discount = pricing_rule.pricing_adjustment([vga_cable])
        expect(discount).to eq 0
      end

      it "applies the pricing adjustment twice if there are two bundles" do
        vga_cable = Product.find_by_sku("vga")
        macbook_pro = Product.find_by_sku("mbp")

        pricing_rule = Specials::FreeVGAWithMacBookPro.pricing_rule
        discount = pricing_rule.pricing_adjustment([vga_cable, vga_cable, macbook_pro, macbook_pro, vga_cable])
        expect(discount).to eq vga_cable.price * 2
      end
    end
  end

  context "SuperIPadDeal" do
    describe "#pricing_adjustment" do
      it "applies a discount if there are 4 ipads" do
        ipad = Product.find_by_sku("ipd")
        four_ipads = Array.new(4) { ipad }

        pricing_rule = Specials::SuperIPadDeal.pricing_rule
        discount = pricing_rule.pricing_adjustment(four_ipads)
        expect(discount).to eq (ipad.price - Specials::SuperIPadDeal::DISCOUNTED_IPAD_PRICE) * 4
      end

      it "applies a discount if there are 8 ipads" do
        ipad = Product.find_by_sku("ipd")
        four_ipads = Array.new(8) { ipad }

        pricing_rule = Specials::SuperIPadDeal.pricing_rule
        discount = pricing_rule.pricing_adjustment(four_ipads)
        expect(discount).to eq (ipad.price - Specials::SuperIPadDeal::DISCOUNTED_IPAD_PRICE) * 8
      end

      it "applies a discount if there are 6 ipads" do
        ipad = Product.find_by_sku("ipd")
        four_ipads = Array.new(6) { ipad }

        pricing_rule = Specials::SuperIPadDeal.pricing_rule
        discount = pricing_rule.pricing_adjustment(four_ipads)
        expect(discount).to eq (ipad.price - Specials::SuperIPadDeal::DISCOUNTED_IPAD_PRICE) * 6
      end

      it "doesn't apply a discount if there are not at least 4 ipads" do
        ipad = Product.find_by_sku("ipd")
        four_ipads = Array.new(3) { ipad }

        pricing_rule = Specials::SuperIPadDeal.pricing_rule
        discount = pricing_rule.pricing_adjustment(four_ipads)
        expect(discount).to eq 0
      end
    end
  end
end
