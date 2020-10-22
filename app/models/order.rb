class Order < ApplicationRecord
  has_many :order_item
  has_many :payment
  belongs_to :shipping
  belongs_to :buyer
  validates :external_id, :external_store_id, :date_created, :total_amount, :total_shipping, :total_amount_with_shipping, :payment, :order_item, :buyer, :shipping, presence: true
  validates_associated :buyer, :shipping
end
