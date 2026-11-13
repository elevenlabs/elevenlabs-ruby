# frozen_string_literal: true

module Elevenlabs
  module Productions
    class Client
      def initialize(client:)
        @client = client
      end

      def orders
        @orders ||= Orders::Client.new(client: @client)
      end
    end
  end
end
