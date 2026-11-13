# frozen_string_literal: true

module Elevenlabs
  module Tokens
    class Client
      def initialize(client:)
        @client = client
      end

      def single_use
        @single_use ||= SingleUse::Client.new(client: @client)
      end
    end
  end
end
