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

  def initialize(discount, required_item_amounts)
    self.required_item_amounts = required_item_amounts
    self.discount = discount
  end

  def pricing_adjustment(items)
    bundles_in_items(items) * discount
  end

  private 

  attr_accessor :required_item_amounts, :discount

  def bundles_in_items(items)
    required_item_amounts.keys.map do |sku|
      (item_amounts(items)[sku] / required_item_amounts[sku]).floor
    end.min
  end

  def item_amounts(items)
    # prevent calculating all the time
    items.each_with_object(Hash.new(0)) do |item, amounts|
      amounts[item.sku] += 1
    end
  end
end
