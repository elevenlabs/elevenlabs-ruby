# frozen_string_literal: true

module Elevenlabs
  module Types
    module TranscriptPlatformEvent
      extend ::Elevenlabs::Internal::Types::Enum

      USER_TURN_TIMEOUT = :user_turn_timeout
      SKIP_TURN_WAIT_ELAPSED = :skip_turn_wait_elapsed

      def self.load(str)
        coerce(::JSON.parse(str, symbolize_names: true))
      end

      def self.dump(value)
        coerced = coerce(value)
        ::JSON.generate(coerced.nil? || !coerced.respond_to?(:to_h) ? coerced : coerced.to_h)
      end
    end
  end
end
