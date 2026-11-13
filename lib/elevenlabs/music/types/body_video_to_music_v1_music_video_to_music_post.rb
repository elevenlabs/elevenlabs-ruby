# frozen_string_literal: true

module Elevenlabs
  module Music
    module Types
      class BodyVideoToMusicV1MusicVideoToMusicPost < ::Elevenlabs::Internal::Types::Model
        field :videos, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
        field :description, -> { String }, optional: true, nullable: true
        field :tags, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
        field :model_id, -> { ::Elevenlabs::Types::MusicModelID }, optional: true, nullable: false
        field :add_sfx, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :separate_tracks, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :use_audio_as_reference, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :sign_with_c2pa, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

        def validate!
          ::Elevenlabs::Validator.validate_array!(videos, 'videos', min_items: 1, max_items: 10)
          ::Elevenlabs::Validator.validate_string!(description, 'description', min_length: 1, max_length: 4100)
          ::Elevenlabs::Validator.validate_array!(tags, 'tags', min_items: 0, max_items: 10)
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
end
