require 'test_helper'

class ShippingTest < ActiveSupport::TestCase
  test "shipping should be valid" do
    receiver_address = ReceiverAddress.new(street_name: "Rua fake de testes", street_number: "3453", comment: "teste", zip_code: "85045020", city: "city fake", state:"state fake", country_cod:"CF", neighborhood: "vila de testes", latitude: -23.629037, longitude: -46.712689)
    shipping = Shipping.new(receiver_address: receiver_address)
    assert shipping.valid?
  end

  test "receiver_addrss should be valid" do
    shipping = Shipping.new
    assert shipping.invalid?
  end
end
