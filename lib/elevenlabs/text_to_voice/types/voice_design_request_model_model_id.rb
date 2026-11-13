# frozen_string_literal: true

module Elevenlabs
  module TextToVoice
    module Types
      module VoiceDesignRequestModelModelID
        extend ::Elevenlabs::Internal::Types::Enum

        ELEVEN_MULTILINGUAL_TTV_V2 = :eleven_multilingual_ttv_v2
        ELEVEN_TTV_V3 = :eleven_ttv_v3

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
