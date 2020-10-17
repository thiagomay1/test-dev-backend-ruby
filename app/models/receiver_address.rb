class ReceiverAddress < ApplicationRecord
  validates :street_name, :street_number, :comment, :zip_code, :city, :state, :country_cod, :neighborhood, :latitude, :longitude, presence: true
end
