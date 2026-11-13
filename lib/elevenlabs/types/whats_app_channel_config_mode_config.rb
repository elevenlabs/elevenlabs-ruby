# frozen_string_literal: true

module Elevenlabs
  module Types
    module WhatsAppChannelConfigModeConfig
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :mode
      member -> { ::Elevenlabs::Types::WhatsAppMessageConfig }, key: 'message'
      member -> { ::Elevenlabs::Types::WhatsAppVoiceConfig }, key: 'voice'

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
