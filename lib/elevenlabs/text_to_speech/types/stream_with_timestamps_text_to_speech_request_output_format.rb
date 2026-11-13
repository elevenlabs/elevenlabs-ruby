# frozen_string_literal: true

module Elevenlabs
  module TextToSpeech
    module Types
      module StreamWithTimestampsTextToSpeechRequestOutputFormat
        extend ::Elevenlabs::Internal::Types::Enum

        MP3_22050_32 = :mp3_22050_32
        MP3_24000_48 = :mp3_24000_48
        MP3_44100_32 = :mp3_44100_32
        MP3_44100_64 = :mp3_44100_64
        MP3_44100_96 = :mp3_44100_96
        MP3_44100_128 = :mp3_44100_128
        MP3_44100_192 = :mp3_44100_192
        PCM_8000 = :pcm_8000
        PCM_16000 = :pcm_16000
        PCM_22050 = :pcm_22050
        PCM_24000 = :pcm_24000
        PCM_32000 = :pcm_32000
        PCM_44100 = :pcm_44100
        PCM_48000 = :pcm_48000
        ULAW_8000 = :ulaw_8000
        ALAW_8000 = :alaw_8000
        OPUS_48000_32 = :opus_48000_32
        OPUS_48000_64 = :opus_48000_64
        OPUS_48000_96 = :opus_48000_96
        OPUS_48000_128 = :opus_48000_128
        OPUS_48000_192 = :opus_48000_192

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
end
