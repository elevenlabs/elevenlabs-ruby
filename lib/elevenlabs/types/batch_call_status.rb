# frozen_string_literal: true

module Elevenlabs
  module Types
    module BatchCallStatus
      extend ::Elevenlabs::Internal::Types::Enum

      PENDING = :pending
      IN_PROGRESS = :in_progress
      COMPLETED = :completed
      FAILED = :failed
      CANCELLED = :cancelled

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
