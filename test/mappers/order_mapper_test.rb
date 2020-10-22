require 'test_helper'
require 'json'

class OrderMapTest < ActiveSupport::TestCase
   test "should map order" do
     json = mock_json
     request = JSON.parse(json)
     order_mapper = OrderMapper.new
     result = order_mapper.map_order(request)
     assert_equal 9987071, result.external_id
     assert_equal 282, result.external_store_id
     assert_equal "2019-06-24T16:45:32.000-04:00".to_datetime, result.date_created
     assert_equal "2019-06-24T16:45:35.000-04:00".to_datetime, result.date_closed
     assert_equal "2019-06-25T13:26:49.000-04:00".to_datetime, result.last_updated
     assert_equal 49.9, result.total_amount
     assert_equal 5.14, result.total_shipping
     assert_equal 55.04, result.total_amount_with_shipping
     assert_equal 55.04, result.paid_amount
     assert_equal "2019-07-22T16:45:35.000-04:00".to_datetime, result.expiration_date
     assert_equal 5.14, result.total_shipping
     assert_equal "paid", result.status
   end

   test "should map buyer" do
     json = mock_json
     request = JSON.parse(json)
     order_mapper = OrderMapper.new
     result = order_mapper.map_order(request)
     buyer_result = result.buyer
     assert_equal 136226073, buyer_result.external_id
     assert_equal "JOHN DOE", buyer_result.nickname
     assert_equal "john@doe.com", buyer_result.email
     assert_equal 41, buyer_result.phone['area_code']
     assert_equal "999999999", buyer_result.phone['number']
     assert_equal "John", buyer_result.first_name
     assert_equal "Doe", buyer_result.last_name
     assert_equal "CPF", buyer_result.billing_info['doc_type']
     assert_equal "09487965477", buyer_result.billing_info['doc_number']
   end

   test "should map shipping" do
     json = mock_json
     request = JSON.parse(json)
     order_mapper = OrderMapper.new
     result = order_mapper.map_order(request)
     shipping_result = result.shipping

     assert_equal 43444211797, shipping_result.external_id
     assert_equal "shipping", shipping_result.shipment_type
     assert_equal "2019-06-24T16:45:33.000-04:00".to_datetime, shipping_result.date_created
     receiver_address_result = shipping_result.receiver_address
     assert_equal 1051695306, receiver_address_result.external_id
     assert_equal "Rua Fake de Testes 3454", receiver_address_result.address_line
     assert_equal "Rua Fake de Testes", receiver_address_result.street_name
     assert_equal "3454", receiver_address_result.street_number
     assert_equal "teste", receiver_address_result.comment
     assert_equal "85045020", receiver_address_result.zip_code
     assert_equal "Cidade de Testes", receiver_address_result.city
     assert_equal "S�o Paulo", receiver_address_result.state
     assert_equal "BR", receiver_address_result.country_cod
     assert_equal "Brasil", receiver_address_result.country_name
     assert_equal "Vila de Testes", receiver_address_result.neighborhood
     assert_equal -23.629037, receiver_address_result.latitude
     assert_equal -46.712689, receiver_address_result.longitude
     assert_equal  "41999999999", receiver_address_result.receiver_phone
   end

   test "should map payments" do
     json = mock_json
     request = JSON.parse(json)
     order_mapper = OrderMapper.new
     result = order_mapper.map_order(request)
     payment_result = result.payment.first

     assert_equal 12312313, payment_result.external_id
     assert_equal 9987071, payment_result.external_order_id
     assert_equal 414138, payment_result.external_payer_id
     assert_equal 1, payment_result.installments
     assert_equal "credit_card", payment_result.payment_type
     assert_equal "paid", payment_result.status
     assert_equal 49.9, payment_result.transaction_amount
     assert_equal 0, payment_result.taxes_amount
     assert_equal 5.14, payment_result.shipping_cost
     assert_equal 55.04, payment_result.total_paid_amount
     assert_equal 55.04, payment_result.installment_amount
     assert_equal "2019-06-24T16:45:35.000-04:00".to_datetime, payment_result.date_approved
     assert_equal "2019-06-24T16:45:33.000-04:00".to_datetime, payment_result.date_created
   end

   test "should map order_items" do
     json = mock_json
     request = JSON.parse(json)
     order_mapper = OrderMapper.new
     result = order_mapper.map_order(request)

     order_item_result = result.order_item.first

     assert_equal "IT4801901403", order_item_result.external_item_id
     assert_equal "Produto de Testes", order_item_result.item_title
     assert_equal 1, order_item_result.quantity
     assert_equal 49.9, order_item_result.unit_price
     assert_equal 49.9, order_item_result.full_unit_price
    end
   
   def mock_json
    return '{
      "id": 9987071,
      "store_id": 282,
      "date_created": "2019-06-24T16:45:32.000-04:00",
      "date_closed": "2019-06-24T16:45:35.000-04:00",
      "last_updated": "2019-06-25T13:26:49.000-04:00",
      "total_amount": 49.9,
      "total_shipping": 5.14,
      "total_amount_with_shipping": 55.04,
      "paid_amount": 55.04,
      "expiration_date": "2019-07-22T16:45:35.000-04:00",
      "total_shipping": 5.14,
      "order_items": [
        {
          "item": {
            "id": "IT4801901403",
            "title": "Produto de Testes"
          },
          "quantity": 1,
          "unit_price": 49.9,
          "full_unit_price": 49.9
        }
      ],
      "payments": [
        {
          "id": 12312313,
          "order_id": 9987071,
          "payer_id": 414138,
          "installments": 1,
          "payment_type": "credit_card",
          "status": "paid",
          "transaction_amount": 49.9,
          "taxes_amount": 0,
          "shipping_cost": 5.14,
          "total_paid_amount": 55.04,
          "installment_amount": 55.04,
          "date_approved": "2019-06-24T16:45:35.000-04:00",
          "date_created": "2019-06-24T16:45:33.000-04:00"
        }
      ],
      "shipping": {
        "id": 43444211797,
        "shipment_type": "shipping",
        "date_created": "2019-06-24T16:45:33.000-04:00",
        "receiver_address": {
          "id": 1051695306,
          "address_line": "Rua Fake de Testes 3454",
          "street_name": "Rua Fake de Testes",
          "street_number": "3454",
          "comment": "teste",
          "zip_code": "85045020",
          "city": {
            "name": "Cidade de Testes"
          },
          "state": {
            "name": "S�o Paulo"
          },
          "country": {
            "id": "BR",
            "name": "Brasil"
          },
          "neighborhood": {
            "id": null,
            "name": "Vila de Testes"
          },
          "latitude": -23.629037,
          "longitude": -46.712689,
          "receiver_phone": "41999999999"
        }
      },
      "status": "paid",
      "buyer": {
        "id": 136226073,
        "nickname": "JOHN DOE",
        "email": "john@doe.com",
        "phone": {
          "area_code": 41,
          "number": "999999999"
        },
        "first_name": "John",
        "last_name": "Doe",
        "billing_info": {
          "doc_type": "CPF",
          "doc_number": "09487965477"
        }
      }
    }'
   end
end
