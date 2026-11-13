# frozen_string_literal: true

module Elevenlabs
  module Types
    module NonStreamingOutputFormats
      extend ::Elevenlabs::Internal::Types::Enum

      WAV_8000 = :wav_8000
      WAV_16000 = :wav_16000
      WAV_22050 = :wav_22050
      WAV_24000 = :wav_24000
      WAV_32000 = :wav_32000
      WAV_44100 = :wav_44100
      WAV_48000 = :wav_48000

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
