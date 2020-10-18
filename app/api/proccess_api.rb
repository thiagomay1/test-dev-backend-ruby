require 'net/http'

class ProccessApi

  def send(payload, now)
    Rails.logger.info "Proccessing order #{payload[:externalCode]}..."
    uri = URI.parse('https://delivery-center-recruitment-ap.herokuapp.com/')
    headers = {"Content-Type": "application/json" }
    if now.present?
      now_formated = now.strftime("%Hh%M - %d/%m/%y")
      headers = headers.merge({"X-Sent": now_formated})
    end
    json = payload.to_json
    response = Net::HTTP::post(uri, json, headers)
    Rails.logger.info "Order #{payload[:externalCode]} proccessed with status=#{response.code}"
    ProccessResult.new(response.code.to_i, response.message)
  end
end
