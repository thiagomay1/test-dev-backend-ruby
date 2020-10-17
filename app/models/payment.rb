class Payment < ApplicationRecord
  belongs_to :order
  validates :payment_type, :total_paid_amount, presence: true
end
