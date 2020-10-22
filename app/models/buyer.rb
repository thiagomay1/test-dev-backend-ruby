class Buyer < ApplicationRecord
  validates :external_id, :first_name, :last_name, :phone, presence: true
  validate :phone_area_code_cannot_be_empty, :phone_number_cannot_be_empty

  def phone_number_cannot_be_empty
    if phone.present? && !phone['number'].present?
       errors.add(:phone, "Number can't be blank")
    end
  end

  def phone_area_code_cannot_be_empty
    if phone.present? && !phone['area_code'].present?
       errors.add(:phone, "Area Code can't be blank")
    end
  end
  def full_name
    "#{first_name} #{last_name}"
  end

  def contact
    "#{phone['area_code']}#{phone['number']}"
  end
end
