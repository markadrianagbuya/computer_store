class PricingRule

  class ThreeForTwoAppleTVs < PricingRule
    def initialize
      apple_tv = Product.find_by_sku("atv")
      super(apple_tv.price, apple_tv.sku => 3)
    end
  end

  class FreeVGAWithMacBookPro < PricingRule
    def initialize
      vga_cable = Product.find_by_sku("vga")
      super(vga_cable.price, vga_cable.sku => 1, "mbp" => 1)
    end
  end

    end


  end

  def initialize(discount, bundle_amounts)
    self.discount = discount
    self.bundle_amounts = bundle_amounts
  end

  def pricing_adjustment(items)
    item_amounts = generate_item_amounts(items)

    bundles_in_items(item_amounts) * discount
  end

  private 

  attr_accessor :bundle_amounts, :discount

  def bundles_in_items(item_amounts)
    bundle_amounts.map do |sku, bundle_amount|
      item_amounts[sku] / bundle_amount
    end.min
  end

  def generate_item_amounts(items)
    items.each_with_object(Hash.new(0)) do |item, amounts|
      amounts[item.sku] += 1
    end
  end
end
