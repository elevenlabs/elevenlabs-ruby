# frozen_string_literal: true

module Elevenlabs
  module Types
    module PendingSubscriptionSwitchResponseModelNextTier
      extend ::Elevenlabs::Internal::Types::Enum

      FREE = :free
      STARTER = :starter
      GO = :go
      CREATOR = :creator
      PRO = :pro
      GROWING_BUSINESS = :growing_business
      SCALE_2024_08_10 = :scale_2024_08_10
      GRANT_TIER_1_2025_07_23 = :grant_tier_1_2025_07_23
      GRANT_TIER_2_2025_07_23 = :grant_tier_2_2025_07_23
      GRANT = :grant
      TRIAL = :trial
      ENTERPRISE = :enterprise

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
