# frozen_string_literal: true

module Elevenlabs
  module Workspaces
    class Client
      def initialize(client:)
        @client = client
      end

      def api_keys
        @api_keys ||= APIKeys::Client.new(client: @client)
      end
    end
  end
end
