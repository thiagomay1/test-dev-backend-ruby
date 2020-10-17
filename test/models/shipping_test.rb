require 'test_helper'

class ShippingTest < ActiveSupport::TestCase
  test "shipping should be valid" do
    receiver_address = ReceiverAddress.new
    shipping = Shipping.new(receiver_address: receiver_address)
    assert shipping.valid?
  end

  test "receiver_addrss should be valid" do
    shipping = Shipping.new
    assert shipping.invalid?
  end
end
