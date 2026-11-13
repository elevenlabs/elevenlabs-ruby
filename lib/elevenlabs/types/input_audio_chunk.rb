# frozen_string_literal: true

module Elevenlabs
  module Types
    class InputAudioChunk < ::Elevenlabs::Internal::Types::Model
      field :message_type, -> { String }, optional: true, nullable: false
      field :audio_base64, -> { String }, optional: false, nullable: false, api_name: 'audio_base_64'
      field :commit, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :previous_text, -> { String }, optional: true, nullable: true
      field :keyterm_library, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

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
