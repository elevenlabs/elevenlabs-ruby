# frozen_string_literal: true

module Elevenlabs
  module Types
    module AgentOutputStatus
      extend ::Elevenlabs::Internal::Types::Enum

      IN_PROGRESS = :in_progress
      COMPLETED = :completed
      REQUIRES_ACTION = :requires_action
      FAILED = :failed
      TIMED_OUT = :timed_out

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
