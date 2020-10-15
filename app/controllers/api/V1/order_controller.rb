module Api
  module V1
    class OrderController < ApplicationController

      def create
        order_mapper = OrderMapper.new
        order = order_mapper.map_order(params)
        if order.invalid?
          render json: order.errors.full_messages
        end
      end
    end
  end
end
