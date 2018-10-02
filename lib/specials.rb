require 'product'
require 'pricing_rule'

module Specials
  def self.all_pricing_rules
    [ThreeForTwoAppleTVs, FreeVGAWithMacBookPro, SuperIPadDeal].map(&:pricing_rule)
  end

  class ThreeForTwoAppleTVs
    def self.pricing_rule
      apple_tv = Product.find_by_sku("atv")

      PricingRule.new(apple_tv.price, apple_tv.sku => 3)
    end
  end

  class FreeVGAWithMacBookPro
    def self.pricing_rule
      vga_cable = Product.find_by_sku("vga")

      PricingRule.new(vga_cable.price, vga_cable.sku => 1, "mbp" => 1)
    end
  end

  class SuperIPadDeal
    DISCOUNTED_IPAD_PRICE = 499.99

    def self.pricing_rule
      super_ipad = Product.find_by_sku("ipd")
      ipad_discount = super_ipad.price - DISCOUNTED_IPAD_PRICE
      PricingRule.new(ipad_discount, { super_ipad.sku => 1 }, { super_ipad.sku => 4 })
    end
  end
end
