class PricingRule
  def initialize(discount, bundle_amounts, thresholds = {})
    self.discount = discount
    self.bundle_amounts = bundle_amounts
    self.thresholds = thresholds
  end

  def pricing_adjustment(items)
    item_amounts = generate_item_amounts(items)
    return 0 unless threshold_reached?(item_amounts)

    bundles_in_items(item_amounts) * discount
  end

  private 

  attr_accessor :bundle_amounts, :discount, :thresholds

  def threshold_reached?(item_amounts)
    thresholds.all? { |sku, threshold| item_amounts[sku] >= threshold }
  end

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
