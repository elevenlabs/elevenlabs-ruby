# frozen_string_literal: true

module Elevenlabs
  module Music
    module Finetunes
      module Types
        class UpdateMusicFinetuneRequestModel < ::Elevenlabs::Internal::Types::Model
          field :name, -> { String }, optional: true, nullable: true
          field :tags, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
          field :primary_genre, -> { String }, optional: true, nullable: true
          field :visibility, -> { ::Elevenlabs::Music::Finetunes::Types::UpdateMusicFinetuneRequestModelVisibility }, optional: true, nullable: true

          def validate!
            ::Elevenlabs::Validator.validate_string!(name, 'name', min_length: 5, max_length: 200)
            ::Elevenlabs::Validator.validate_array!(tags, 'tags', max_items: 5)
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
