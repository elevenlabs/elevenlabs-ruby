# frozen_string_literal: true

module Elevenlabs
  module Workspaces
    class Client
      def initialize(client:, base_url: nil, environment: nil)
        @client = client
        @base_url = base_url
        @environment = environment
      end

      def api_keys
        @api_keys ||= APIKeys::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end
    end
  end
end
