# frozen_string_literal: true

module Elevenlabs
  module Errors
    # Raised when a WebSocket connection cannot carry a message: it is closed, or it dropped before a
    # held message could be delivered.
    class WebSocketError < ApiError
    end

    # Raised when the server answers the WebSocket opening handshake with anything but an upgrade.
    class WebSocketHandshakeError < WebSocketError
      # @return [Integer, nil] The HTTP status the server answered the handshake with.
      attr_reader :status_code

      # @param message [String]
      # @param status_code [Integer, nil]
      def initialize(message, status_code: nil)
        super(message)
        @status_code = status_code
      end
    end
  end
end
