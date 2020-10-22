class Shipping < ApplicationRecord
  belongs_to :receiver_address
  validates :receiver_address, presence: true
  validates_associated :receiver_address
end
