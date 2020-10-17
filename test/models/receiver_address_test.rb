require 'test_helper'

class ReceiverAddressTest < ActiveSupport::TestCase
  test "receiver_address should be valid" do
    receiver_address = build_receiver_address
    assert receiver_address.valid?
  end

  test "street_name should be valid" do
    receiver_address = build_receiver_address
    receiver_address.street_name = nil
    assert receiver_address.invalid?
  end

  test "street_number should be valid" do
    receiver_address = build_receiver_address
    receiver_address.street_number = nil
    assert receiver_address.invalid?
  end

  test "comment should be valid" do
    receiver_address = build_receiver_address
    receiver_address.comment = nil
    assert receiver_address.invalid?
  end

  test "zip_code should be valid" do
    receiver_address = build_receiver_address
    receiver_address.zip_code = nil
    assert receiver_address.invalid?
  end

  test "city should be valid" do
    receiver_address = build_receiver_address
    receiver_address.zip_code = nil
    assert receiver_address.invalid?
  end

  test "state should be valid" do
    receiver_address = build_receiver_address
    receiver_address.state = nil
    assert receiver_address.invalid?
  end

  test "country_cod should be valid" do
    receiver_address = build_receiver_address
    receiver_address.country_cod = nil
    assert receiver_address.invalid?
  end

  test "neighborhood should be valid" do
    receiver_address = build_receiver_address
    receiver_address.neighborhood = nil
    assert receiver_address.invalid?
  end

  test "latitude should be valid" do
    receiver_address = build_receiver_address
    receiver_address.latitude = nil
    assert receiver_address.invalid?
  end

  test "longitude should be valid" do
    receiver_address = build_receiver_address
    receiver_address.longitude = nil
    assert receiver_address.invalid?
  end

  private
  def build_receiver_address
    ReceiverAddress.new(street_name: "Rua fake de testes", street_number: "3453", comment: "teste", zip_code: "85045020", city: "city fake", state:"state fake", country_cod:"CF", neighborhood: "vila de testes", latitude: -23.629037, longitude: -46.712689)
  end
end
