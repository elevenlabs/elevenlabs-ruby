# frozen_string_literal: true

module Elevenlabs
  module Types
    module PlatformCategory
      extend ::Elevenlabs::Internal::Types::Enum

      VOICE = :voice
      SILENCE = :silence
      BURST = :burst
      ASR = :asr
      TEXT_MESSAGE = :text_message
      RECEPTION = :reception
      V3_ADDON = :v3_addon
      V4_ADDON = :v4_addon
      RAG_ADDON = :rag_addon
      OTHER = :other

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
