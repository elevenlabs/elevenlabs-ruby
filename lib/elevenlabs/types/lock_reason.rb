# frozen_string_literal: true

module Elevenlabs
  module Types
    module LockReason
      extend ::Elevenlabs::Internal::Types::Enum

      TRIAL_ENDED = :trial_ended
      SUBSCRIPTION_DOWNGRADE = :subscription_downgrade
      EXPOSED_PUBLICLY = :exposed_publicly
      SELF_DISABLED = :self_disabled

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
