require 'test_helper'
require 'json'

class ProccessAdapterTest < ActiveSupport::TestCase
   test "should return proccess json" do
     adapter = ProccessAdapter.new
     phone = {area_code: 41, number: "999999999"}
     buyer = Buyer.new(first_name: "John", last_name: "Doe", email: "teste@teste.com", phone: phone)
     receiver_address = ReceiverAddress.new(country_cod: "Br", state: "SP", city: "Cidade dos testes", neighborhood: "Bairro fake", street_name: "Rua de Testes Fake", comment: "galpao", latitude: -23.629037, longitude: -23.629037, zip_code: 84124123, street_number: "50")
     shipping = Shipping.new(receiver_address: receiver_address)
     payment = Payment.new(payment_type: "teste", total_paid_amount: 142)
     order_item = OrderItem.new(external_item_id: "IT4801901403", item_title: "Produto de Testes", quantity: 1, unit_price: 49.9, full_unit_price: 49.9)
     order = Order.new(external_id: 123412, external_store_id: 1243, date_created: Time.now, total_amount: 49.9, total_shipping: 5.14, total_amount_with_shipping: 55.04, payment: [payment], order_item: [order_item], buyer: buyer, shipping: shipping)


     result = adapter.adapt(order)
     assert_equal order.external_id.to_s, result[:externalCode]
     assert_equal order.external_store_id, result[:storeId]
     assert_equal order.total_amount.to_s, result[:subTotal]
     assert_equal order.total_shipping.to_s, result[:deliveryFee]
     assert_equal order.total_amount_with_shipping.to_s, result[:total]
     assert_equal order.date_created, result[:dtOrderCreate]

     assert_equal receiver_address.country_cod.upcase, result[:country]
     assert_equal receiver_address.state.upcase, result[:state]
     assert_equal receiver_address.city, result[:city]
     assert_equal receiver_address.neighborhood, result[:district]
     assert_equal receiver_address.street_name, result[:street]
     assert_equal receiver_address.comment, result[:complement]
     assert_equal receiver_address.latitude, result[:latitude]
     assert_equal receiver_address.longitude, result[:longitude]
     assert_equal receiver_address.zip_code, result[:postalCode]
     assert_equal receiver_address.street_number, result[:number]

     result_item = result[:items].first
     assert_equal order_item.external_item_id, result_item[:externalCode]     
     assert_equal order_item.item_title, result_item[:name]     
     assert_equal order_item.quantity, result_item[:quantity]     
     assert_equal order_item.unit_price, result_item[:price]     
     assert_equal order_item.full_unit_price, result_item[:total]     
     assert_equal [], result_item[:subItems]
     result_payment = result[:payments].first
     assert_equal payment.payment_type.upcase, result_payment[:type]
     assert_equal payment.total_paid_amount, result_payment[:value]

     result_customer = result[:customer]
     assert_equal buyer.external_id.to_s, result_customer[:externalCode]
     assert_equal "JOHN DOE", result_customer[:name] 
     assert_equal buyer.email, result_customer[:email]
     assert_equal "41999999999", result_customer[:contact]
   end
end 
