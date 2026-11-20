# frozen_string_literal: true

module Elevenlabs
  module Types
    module TwilioTransferOutputConfig
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::TwilioColdBlindTransferConfigOutput }, key: 'twilio_cold_blind_transfer'
      member -> { ::Elevenlabs::Types::TwilioWarmConferenceTransferConfigOutput }, key: 'twilio_warm_conference_transfer'

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
