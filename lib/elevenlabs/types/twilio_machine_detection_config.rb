# frozen_string_literal: true

module Elevenlabs
  module Types
    class TwilioMachineDetectionConfig < ::Elevenlabs::Internal::Types::Model
      field :mode, -> { ::Elevenlabs::Types::TwilioMachineDetectionMode }, optional: true, nullable: false
      field :actions, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TwilioMachineDetectionRule] }, optional: true, nullable: false

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
