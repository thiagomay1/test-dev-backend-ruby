class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.bigint :external_id
      t.integer :external_store_id
      t.datetime :date_created
      t.datetime :date_closed
      t.datetime :last_updated
      t.decimal :total_amount
      t.decimal :total_shipping
      t.decimal :total_amount_with_shipping
      t.decimal :paid_amount
      t.datetime :expiration_date
      t.string :status
      t.references :shipping, null: false, foreign_key: true
      t.references :buyer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
