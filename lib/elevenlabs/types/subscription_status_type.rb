# frozen_string_literal: true

module Elevenlabs
  module Types
    module SubscriptionStatusType
      extend ::Elevenlabs::Internal::Types::Enum

      TRIALING = :trialing
      ACTIVE = :active
      INCOMPLETE = :incomplete
      PAST_DUE = :past_due
      FREE = :free
      FREE_DISABLED = :free_disabled

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
