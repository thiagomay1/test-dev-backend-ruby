class CreateBuyers < ActiveRecord::Migration[6.0]
  def change
    create_table :buyers do |t|
      t.bigint :external_id
      t.string :nickname
      t.string :email
      t.string :first_name
      t.string :last_name
      t.jsonb :phone
      t.jsonb :billing_info

      t.timestamps
    end
  end
end
