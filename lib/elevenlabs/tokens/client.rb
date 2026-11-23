# frozen_string_literal: true

module Elevenlabs
  module Tokens
    class Client
      def initialize(client:, base_url: nil, environment: nil)
        @client = client
        @base_url = base_url
        @environment = environment
      end

      def single_use
        @single_use ||= SingleUse::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end
    end
  end
end
