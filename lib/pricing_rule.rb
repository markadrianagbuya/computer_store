class PricingRule
  class ThreeForTwoAppleTVs
    def initialize
      self.apple_tv = Product.find_by_sku("atv")
    end

    def pricing_adjustment(items)
      apple_tvs = items.select { |item| item.sku == apple_tv.sku }
      apple_tv.price * (apple_tvs.count / 3).floor
    end

    private

    attr_accessor :apple_tv
  end
end
