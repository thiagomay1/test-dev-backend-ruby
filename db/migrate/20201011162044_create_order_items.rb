class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.string :external_item_id
      t.string :item_title
      t.integer :quantity
      t.decimal :unit_price
      t.decimal :full_unit_price
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
