class OrderItem < ApplicationRecord
  belongs_to :order
  validates :external_item_id, :item_title, :quantity, :unit_price, :full_unit_price, presence: true
end
