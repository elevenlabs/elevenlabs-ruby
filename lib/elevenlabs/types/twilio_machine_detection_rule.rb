# frozen_string_literal: true

module Elevenlabs
  module Types
    class TwilioMachineDetectionRule < ::Elevenlabs::Internal::Types::Model
      field :action, -> { ::Elevenlabs::Types::TwilioMachineDetectionAction }, optional: false, nullable: false
      field :answered_by, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TwilioAnsweredBy] }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(answered_by, 'answered_by', min_items: 1)
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
