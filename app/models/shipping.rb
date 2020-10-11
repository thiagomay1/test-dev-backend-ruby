class Shipping < ApplicationRecord
  has_one :receiver_address
end
