class ProccessAdapter
  def adapt(order)
    hash_items = []
    order.order_item.each do |oi|
      hash_item = {
        externalCode: oi.external_item_id,
        name: oi.item_title,
        quantity: oi.quantity,
        price: oi.unit_price,
        total: oi.full_unit_price,
        subItems: []
      }
      hash_items << hash_item
    end
    hash_payments = []
    order.payment.each do |payment|
      hash_payment = {
        value: payment.total_paid_amount,
        type: payment.payment_type.upcase
      }
      hash_payments << hash_payment
    end
    return { 
      externalCode: order.external_id.to_s,
      storeId: order.external_store_id,
      dtOrderCreate: order.date_created,
      subTotal: order.total_amount.to_s,
      deliveryFee: order.total_shipping.to_s,
      total: order.total_amount_with_shipping.to_s,
      country: order.shipping.receiver_address.country_cod.upcase,
      state: order.shipping.receiver_address.state.upcase,
      city: order.shipping.receiver_address.city,
      district: order.shipping.receiver_address.neighborhood,
      street: order.shipping.receiver_address.street_name,
      complement: order.shipping.receiver_address.comment,
      latitude: order.shipping.receiver_address.latitude,
      longitude: order.shipping.receiver_address.longitude,
      postalCode: order.shipping.receiver_address.zip_code,
      number: order.shipping.receiver_address.street_number,
      items: hash_items,
      payments: hash_payments,
      customer:{
        externalCode: order.buyer.external_id.to_s,
        name: order.buyer.full_name.upcase,
        email: order.buyer.email,
        contact: order.buyer.contact
      }
    }
  end
end
