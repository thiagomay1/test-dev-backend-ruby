class OrderMapper
  def map_order(params)
    buyer = Buyer.new
    params_buyer = params['buyer']
    buyer.external_id = params_buyer['id']
    buyer.nickname = params_buyer['nickname']
    buyer.email = params_buyer['email']
    buyer.phone = { area_code: params_buyer['phone']['area_code'], number: params_buyer['phone']['number'] }
    buyer.first_name = params_buyer['first_name']
    buyer.last_name = params_buyer['last_name']
    buyer.billing_info = { doc_type: params_buyer['billing_info']['doc_type'], doc_number: params_buyer['billing_info']['doc_number'] }

    params_shipping = params['shipping']
    shipping = Shipping.new
    shipping.external_id = params_shipping['id']
    shipping.shipment_type= params_shipping['shipment_type']
    shipping.date_created = params_shipping['date_created']
    params_receiver_address = params_shipping['receiver_address']
    receiver_address = ReceiverAddress.new
    receiver_address.external_id = params_receiver_address['id']
    receiver_address.address_line = params_receiver_address['address_line']
    receiver_address.street_name = params_receiver_address['street_name']
    receiver_address.street_number = params_receiver_address['street_number']
    receiver_address.comment = params_receiver_address['comment']
    receiver_address.zip_code = params_receiver_address['zip_code']
    receiver_address.city = params_receiver_address['city']['name']
    receiver_address.state = params_receiver_address['state']['name']
    receiver_address.country_cod = params_receiver_address['country']['id']
    receiver_address.country_name = params_receiver_address['country']['name']
    receiver_address.neighborhood = params_receiver_address['neighborhood']['name']
    receiver_address.latitude = params_receiver_address['latitude']
    receiver_address.longitude = params_receiver_address['longitude']
    receiver_address.receiver_phone = params_receiver_address['receiver_phone']
    shipping.receiver_address = receiver_address

    order = Order.new
    order.external_id = params['id']
    order.external_store_id = params['store_id']
    order.date_created = params['date_created']
    order.date_closed = params['date_closed']
    order.last_updated = params['last_updated']
    order.total_amount = params['total_amount']
    order.total_shipping = params['total_shipping']
    order.total_amount_with_shipping = params['total_amount_with_shipping']
    order.paid_amount = params['paid_amount']
    order.expiration_date = params['expiration_date']
    order.total_shipping = params['total_shipping']
    order.status = params['status']
    order.buyer = buyer
    order.shipping = shipping

    params['payments'].each do |p|
      payment = Payment.new
      payment.external_id = p['id']
      payment.external_order_id = p['order_id']
      payment.external_payer_id = p['payer_id']
      payment.installments = p['installments']
      payment.payment_type = p['payment_type']
      payment.status = p['status']
      payment.transaction_amount = p['transaction_amount']
      payment.taxes_amount = p['taxes_amount']
      payment.shipping_cost = p['shipping_cost']
      payment.total_paid_amount = p['total_paid_amount']
      payment.installment_amount = p['installment_amount']
      payment.date_approved = p['date_approved']
      payment.date_created = p['date_created']
      order.payment << payment
    end

    params['order_items'].each do |oi|
      order_item = OrderItem.new
      order_item.external_item_id = oi['item']['id']
      order_item.item_title = oi['item']['title']
      order_item.quantity = oi['quantity']
      order_item.unit_price = oi['unit_price']
      order_item.full_unit_price = oi['full_unit_price']
      order.order_item << order_item
    end

    return order
  end

end
