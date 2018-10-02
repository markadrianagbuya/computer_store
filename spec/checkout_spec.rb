require 'checkout'

RSpec.describe Checkout do
  describe "#total" do
    it "returns 0 if there are no items checked out" do
      expect(Checkout.new.total).to eq 0
    end
  end
end
