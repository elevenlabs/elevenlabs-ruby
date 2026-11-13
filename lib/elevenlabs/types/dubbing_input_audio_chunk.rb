# frozen_string_literal: true

module Elevenlabs
  module Types
    class DubbingInputAudioChunk < ::Elevenlabs::Internal::Types::Model
      field :message_type, -> { ::Elevenlabs::Types::DubbingInputAudioChunkMessageType }, optional: false, nullable: false
      field :audio_base64, -> { String }, optional: false, nullable: false, api_name: 'audio_base_64'

      def validate!
        ::Elevenlabs::Validator.validate_string!(audio_base64, 'audio_base_64', min_length: 1)
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
