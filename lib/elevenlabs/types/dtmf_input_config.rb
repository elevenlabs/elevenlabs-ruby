# frozen_string_literal: true

module Elevenlabs
  module Types
    class DtmfInputConfig < ::Elevenlabs::Internal::Types::Model
      field :dtmf_input_timeout, -> { Float }, optional: true, nullable: false
      field :hash_terminator, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :redact_input, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

      def validate!
        Validator.validate_number!(dtmf_input_timeout, 'dtmf_input_timeout', min: 0.5, max: 10)
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
