# frozen_string_literal: true

module Elevenlabs
  module Internal
    module WebSocket
      # The lifecycle states a WebSocket connection moves through.
      module State
        CONNECTING = :connecting
        OPEN = :open
        CLOSING = :closing
        CLOSED = :closed
      end
    end
  end
end
