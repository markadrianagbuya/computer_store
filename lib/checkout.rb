class Checkout
  attr_accessor :scanned_items
  def initialize(scanned_items = [])
    self.scanned_items = scanned_items
  end

  def total
    scanned_items.sum(&:price)
  end

  def scan(item)
    scanned_items << item
  end
end
