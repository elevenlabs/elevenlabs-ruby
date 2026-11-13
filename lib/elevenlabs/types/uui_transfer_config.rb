# frozen_string_literal: true

module Elevenlabs
  module Types
    class UuiTransferConfig < ::Elevenlabs::Internal::Types::Model
      field :data, -> { String }, optional: false, nullable: false
      field :protocol_discriminator, -> { String }, optional: true, nullable: true
      field :protocol_discriminator_mode, -> { ::Elevenlabs::Types::UuiTransferConfigProtocolDiscriminatorMode }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(data, 'data', max_length: 8192)
        ::Elevenlabs::Validator.validate_string!(protocol_discriminator, 'protocol_discriminator', pattern: /^[0-9A-Fa-f]{2}$/)
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
