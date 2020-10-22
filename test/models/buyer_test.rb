require 'test_helper'

class BuyerTest < ActiveSupport::TestCase
   test "buyer is valid" do
     buyer = build_buyer
     assert buyer.valid?
   end
  
   test "external_id should not be empty" do
     buyer = build_buyer
     buyer.external_id = nil
     assert buyer.invalid?
   end

  test "first_name should not be empty" do
     buyer = build_buyer
     buyer.first_name = nil
     assert buyer.invalid?
  end

  test "last_name should not be empty" do
     buyer = build_buyer
     buyer.last_name = nil
     assert buyer.invalid?
  end

  test "phone should not be empty" do
     buyer = build_buyer
     buyer.phone = nil
     assert buyer.invalid?
  end

  test "phone should not be empty 2" do
     buyer = build_buyer
     buyer.phone['area_code'] = nil
     assert buyer.invalid?
  end

  test "phone should not be empty 3" do
     buyer = build_buyer
     buyer.phone['number'] = nil
     assert buyer.invalid?
   end

   def build_buyer
     phone = {area_code: 41, number: "99999999"}
     Buyer.new(external_id: 129421, first_name: "John", last_name: "Doe", phone: phone)
   end
end
