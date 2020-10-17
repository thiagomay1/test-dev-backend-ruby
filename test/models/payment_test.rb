require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  test "payment should be valid" do
    payment = build_payment
    puts payment.valid?
    puts payment.errors.full_messages
    assert payment.valid?
  end

  test "payment_type should not be empty" do
    payment = build_payment
    payment.payment_type = nil
    assert payment.invalid? 
  end

  test "total_paid_amount should not be empty" do
    payment = build_payment
    payment.total_paid_amount = nil
    assert payment.invalid? 
  end

  private 
  def build_payment
    order = Order.new
    Payment.new(payment_type: "credit_card", total_paid_amount: 55.04, order: order)
  end
end
