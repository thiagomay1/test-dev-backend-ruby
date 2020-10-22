class CreateReceiverAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :receiver_addresses do |t|
      t.bigint :external_id
      t.string :address_line
      t.string :street_name
      t.string :street_number
      t.string :comment
      t.string :zip_code
      t.string :city
      t.string :state
      t.string :country_cod
      t.string :country_name
      t.string :neighborhood
      t.decimal :latitude
      t.decimal :longitude
      t.string :receiver_phone

      t.timestamps
    end
  end
end
