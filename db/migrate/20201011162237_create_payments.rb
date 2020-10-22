class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :external_id
      t.integer :external_order_id
      t.integer :external_payer_id
      t.integer :installments
      t.string :payment_type
      t.string :status
      t.decimal :transaction_amount
      t.integer :taxes_amount
      t.decimal :shipping_cost
      t.decimal :total_paid_amount
      t.decimal :installment_amount
      t.datetime :date_approved
      t.datetime :date_created
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end

