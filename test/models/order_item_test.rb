require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  test "OrderItem should be valid" do
    order_item = build_order_item
    assert order_item.valid?
  end

  test "item id should not be empty" do
    order_item = build_order_item
    order_item.external_item_id = nil
    assert order_item.invalid?
    assert_equal "Item Id can't be blank", order_item.errors.full_messages.first
  end

  test "item title should not be empty" do
    order_item = build_order_item
    order_item.item_title = nil
    assert order_item.invalid?
    assert_equal "Item title can't be blank", order_item.errors.full_messages.first
  end

  test "quantity should not be empty" do
    order_item = build_order_item
    order_item.quantity = nil
    assert order_item.invalid?
  end

  test "unit_price should not be empty" do
    order_item = build_order_item
    order_item.unit_price = nil
    assert order_item.invalid?
  end

  test "full unit price should not be empty" do
    order_item = build_order_item
    order_item.full_unit_price = nil
    assert order_item.invalid?
  end

  private
  def build_order_item
    order = Order.new
    OrderItem.new(external_item_id: "IT4801901403", item_title: "Produto de Testes", quantity: 1, unit_price: 49.9, full_unit_price: 49.9, order: order)
  end
end
