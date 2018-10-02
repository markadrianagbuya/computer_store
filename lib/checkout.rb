class Checkout
  attr_accessor :scanned_items, :pricing_rules
  def initialize(pricing_rules = [], scanned_items = [])
    self.pricing_rules = pricing_rules
    self.scanned_items = scanned_items
  end

  def total
    scanned_items.sum(&:price) - total_discount
  end

  def scan(item)
    scanned_items << item
  end

  private
  
  def total_discount
    pricing_rules.sum { |pricing_rule| pricing_rule.pricing_adjustment(scanned_items) }
  end
end
