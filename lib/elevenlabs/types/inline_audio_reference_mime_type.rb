# frozen_string_literal: true

module Elevenlabs
  module Types
    module InlineAudioReferenceMimeType
      extend ::Elevenlabs::Internal::Types::Enum

      AUDIO_MPEG = :'audio/mpeg'
      AUDIO_WAV = :'audio/wav'

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
