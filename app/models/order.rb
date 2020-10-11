class Order < ApplicationRecord
  has_many :order_item
  has_many :payment
  has_one :shipping
  has_one :buyer
end
