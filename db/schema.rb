# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_11_162237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buyers", force: :cascade do |t|
    t.bigint "external_id"
    t.string "nickname"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.jsonb "phone"
    t.jsonb "billing_info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.string "external_item_id"
    t.string "item_title"
    t.integer "quantity"
    t.decimal "unit_price"
    t.decimal "full_unit_price"
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "external_id"
    t.integer "external_store_id"
    t.datetime "date_created"
    t.datetime "date_closed"
    t.datetime "last_updated"
    t.decimal "total_amount"
    t.decimal "total_shipping"
    t.decimal "total_amount_with_shipping"
    t.decimal "paid_amount"
    t.datetime "expiration_date"
    t.string "status"
    t.bigint "shipping_id", null: false
    t.bigint "buyer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_orders_on_buyer_id"
    t.index ["shipping_id"], name: "index_orders_on_shipping_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "external_id"
    t.integer "external_order_id"
    t.integer "external_payer_id"
    t.integer "installments"
    t.string "payment_type"
    t.string "status"
    t.decimal "transaction_amount"
    t.integer "taxes_amount"
    t.decimal "shipping_cost"
    t.decimal "total_paid_amount"
    t.decimal "installment_amount"
    t.datetime "date_approved"
    t.datetime "date_created"
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "receiver_addresses", force: :cascade do |t|
    t.bigint "external_id"
    t.string "address_line"
    t.string "street_name"
    t.string "street_number"
    t.string "comment"
    t.string "zip_code"
    t.string "city"
    t.string "state"
    t.string "country_cod"
    t.string "country_name"
    t.string "neighborhood"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "receiver_phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shippings", force: :cascade do |t|
    t.bigint "external_id"
    t.string "shipment_type"
    t.datetime "date_created"
    t.bigint "receiver_address_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receiver_address_id"], name: "index_shippings_on_receiver_address_id"
  end

  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "buyers"
  add_foreign_key "orders", "shippings"
  add_foreign_key "payments", "orders"
  add_foreign_key "shippings", "receiver_addresses"
end
