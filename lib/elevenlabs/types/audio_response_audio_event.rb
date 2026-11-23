# frozen_string_literal: true

module Elevenlabs
  module Types
    class AudioResponseAudioEvent < ::Elevenlabs::Internal::Types::Model
      field :audio_base64, -> { String }, optional: false, nullable: false, api_name: 'audio_base_64'
      field :event_id, -> { Integer }, optional: false, nullable: false
      field :alignment, -> { ::Elevenlabs::Types::AudioResponseAudioEventAlignment }, optional: true, nullable: false
      field :is_final, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
