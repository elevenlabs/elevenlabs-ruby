# frozen_string_literal: true

module Elevenlabs
  module Music
    module Finetunes
      module Types
        class BodyCreateMusicFinetuneV1MusicFinetunesPost < ::Elevenlabs::Internal::Types::Model
          field :name, -> { String }, optional: false, nullable: false
          field :primary_genre, -> { String }, optional: false, nullable: false
          field :files, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
          field :tags, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
          field :visibility, -> { ::Elevenlabs::Music::Finetunes::Types::BodyCreateMusicFinetuneV1MusicFinetunesPostVisibility }, optional: true, nullable: true
          field :model_id, -> { ::Elevenlabs::Types::MusicModelID }, optional: true, nullable: false

          def validate!
            ::Elevenlabs::Validator.validate_string!(name, 'name', min_length: 5, max_length: 200)
            ::Elevenlabs::Validator.validate_array!(files, 'files', max_items: 50)
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
end
