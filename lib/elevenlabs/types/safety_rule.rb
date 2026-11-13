# frozen_string_literal: true

module Elevenlabs
  module Types
    module SafetyRule
      extend ::Elevenlabs::Internal::Types::Enum

      SEXUAL_MINORS = :sexual_minors
      FORGET_MODERATION = :forget_moderation
      EXTREMISM = :extremism
      SCAM_FRAUD = :scam_fraud
      POLITICAL = :political
      SELF_HARM = :self_harm
      ILLEGAL_DISTRIBUTION_MEDICAL = :illegal_distribution_medical
      SEXUAL_ADULTS = :sexual_adults
      UNKNOWN = :unknown

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
