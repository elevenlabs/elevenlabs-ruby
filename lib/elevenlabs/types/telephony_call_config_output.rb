# frozen_string_literal: true

module Elevenlabs
  module Types
    class TelephonyCallConfigOutput < ::Elevenlabs::Internal::Types::Model
      field :ringing_timeout_secs, -> { Integer }, optional: true, nullable: false
      field :twilio_call_recording_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :twilio_machine_detection, -> { ::Elevenlabs::Types::TwilioMachineDetectionConfig }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_integer!(ringing_timeout_secs, 'ringing_timeout_secs', min: 1, max: 999)
      end

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
