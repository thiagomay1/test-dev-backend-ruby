require 'test_helper'
require 'date'
require 'json'

class ProccessApiTest < ActiveSupport::TestCase
   test "success call" do
     service = ProccessApi.new
     payload = mock_json
     stub_post = stub_request(:post, 'https://delivery-center-recruitment-ap.herokuapp.com/')
       .with(body: payload, headers: {"Content-Type": 'application/json', "X-Sent": '09h25 - 24/10/19' })
     now = DateTime.parse('2019-10-24T09:25:00')

     result = service.send(payload, now)

     assert result.is_success
     assert_equal "", result.message
     assert_requested stub_post
   end

   test "error call" do
     service = ProccessApi.new
     payload = mock_json
     stub_post = stub_request(:post, 'https://delivery-center-recruitment-ap.herokuapp.com/')
       .with(body: payload, headers: {"Content-Type": 'application/json' })
       .to_return(status: [500], body: "Internal Server Error")

     result = service.send(payload, nil)

     assert !result.is_success
     assert_equal "Internal Server Error", result.message
     assert_requested stub_post
   end


   def mock_json
     {"externalCode":"9987071","storeId":282,"subTotal":"49.90","deliveryFee":"5.14","total":"55.04","country":"BR","state":"SP","city":"Cidade de Testes","district":"Bairro Fake","street":"Rua de Testes Fake","complement":"galpao","latitude":-23.629037,"longitude":-46.712689,"dtOrderCreate":"2019-06-27T19:59:08.251Z","postalCode":"85045020","number":"0","customer":{"externalCode":"136226073","name":"JOHN DOE","email":"john@doe.com","contact":"41999999999",},"items":[{"externalCode":"IT4801901403","name":"Produto de Testes","price":49.9,"quantity":1,"total":49.9,"subItems":[]}],"payments":[{"type":"CREDIT_CARD","value":55.04}]}
   end
end
