# frozen_string_literal: true

module Elevenlabs
  module Types
    class TranslateInputAudioChunk < ::Elevenlabs::Internal::Types::Model
      field :message_type, -> { ::Elevenlabs::Types::TranslateInputAudioChunkMessageType }, optional: false, nullable: false
      field :audio_base64, -> { String }, optional: false, nullable: false, api_name: 'audio_base_64'

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
