require 'test_helper'

class OrderTest < ActiveSupport::TestCase
   test "order should be valid" do
     order = build_order
     assert order.valid?
   end

   test "id should not be empty" do
     order = build_order
     order.external_id = nil
     assert order.invalid?
     assert_equal "Id can't be blank", order.errors.full_messages.first
   end

   test "store_id should not be empty" do
     order = build_order
     order.external_store_id = nil
     assert order.invalid?
     assert_equal "Store Id can't be blank", order.errors.full_messages.first
   end

   test "date_created should not be empty" do
     order = build_order
     order.date_created = nil
     assert order.invalid?
   end

   test "total_amount should not be empty" do
     order = build_order
     order.total_amount = nil
     assert order.invalid?
   end

   test "total_shipping should not be empty" do
     order = build_order
     order.total_shipping = nil
     assert order.invalid?
   end

   test "paid_amount should not be empty" do
     order = build_order
     order.paid_amount = nil
     assert order.invalid?
   end

   test "order_item should not be empty" do
     order = build_order
     order.order_item = []
     assert order.invalid?
   end

   test "payments should not be empty" do
     order = build_order
     order.payment = []
     assert order.invalid?
   end

   test "shipping should not be empty" do
     order = build_order
     order.shipping = nil
     assert order.invalid?
   end

   test "buyer should not be empty" do
     order = build_order
     order.buyer = nil
     assert order.invalid?
   end

   private
   def build_order
     buyer = Buyer.new
     shipping = Shipping.new
     payment = Payment.new
     order_item = OrderItem.new(external_item_id: "IT4801901403", item_title: "Produto de Testes", quantity: 1, unit_price: 49.9, full_unit_price: 49.9)
     Order.new(external_id: 123412, external_store_id: 1243, date_created: Time.now, total_amount: 49.9, total_shipping: 5.14, paid_amount: 55.04, payment: [payment], order_item: [order_item], buyer: buyer, shipping: shipping)
   end
end
