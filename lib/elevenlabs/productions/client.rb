# frozen_string_literal: true

module Elevenlabs
  module Productions
    class Client
      def initialize(client:, base_url: nil, environment: nil)
        @client = client
        @base_url = base_url
        @environment = environment
      end

      def orders
        @orders ||= Orders::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end
    end
  end
end
