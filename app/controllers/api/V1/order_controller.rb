module Api
  module V1
    class OrderController < ApplicationController
      def initialize
        @order_mapper = OrderMapper.new
        @adapter = ProccessAdapter.new
        @proccess_api = ProccessApi.new
      end

      def create
        order = @order_mapper.map_order(params)
        if !order.save
          render json: order.errors.full_messages
        end
        request = @adapter.adapt(order)
        result = @proccess_api.send(request)
        render json: result.message.to_json, status: result.code
      end
    end
  end
end
