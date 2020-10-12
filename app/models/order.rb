class Order < ApplicationRecord
  has_many :order_item
  has_many :payment
  belongs_to :shipping
  belongs_to :buyer
end
