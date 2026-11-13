# frozen_string_literal: true

module Elevenlabs
  module Types
    class SubmitWhatsAppChannelConfig < ::Elevenlabs::Internal::Types::Model
      field :channel, -> { ::Elevenlabs::Types::SubmitWhatsAppChannelConfigChannel }, optional: true, nullable: false
      field :whatsapp_phone_number_id, -> { String }, optional: false, nullable: false
      field :mode_config, -> { ::Elevenlabs::Types::SubmitWhatsAppChannelConfigModeConfig }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(whatsapp_phone_number_id, 'whatsapp_phone_number_id', min_length: 1)
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
