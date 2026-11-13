# frozen_string_literal: true

module Elevenlabs
  module Types
    module ScribeSessionTimeLimitExceededErrorMessageType
      extend ::Elevenlabs::Internal::Types::Enum

      SESSION_TIME_LIMIT_EXCEEDED = :session_time_limit_exceeded

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
