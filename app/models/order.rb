class Order < ApplicationRecord
  has_many :order_item
  has_many :payment
  belongs_to :shipping
  belongs_to :buyer
  validates :external_id, :external_store_id, :date_created, :total_amount, :total_shipping, :paid_amount, :payment, :order_item, :buyer, :shipping, presence: true
end
