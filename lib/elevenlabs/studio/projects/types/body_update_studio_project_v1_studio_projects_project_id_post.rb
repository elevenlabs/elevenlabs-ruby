# frozen_string_literal: true

module Elevenlabs
  module Studio
    module Projects
      module Types
        class BodyUpdateStudioProjectV1StudioProjectsProjectIDPost < ::Elevenlabs::Internal::Types::Model
          field :name, -> { String }, optional: false, nullable: false
          field :default_title_voice_id, -> { String }, optional: false, nullable: false
          field :default_paragraph_voice_id, -> { String }, optional: false, nullable: false
          field :title, -> { String }, optional: true, nullable: true
          field :author, -> { String }, optional: true, nullable: true
          field :isbn_number, -> { String }, optional: true, nullable: true
          field :volume_normalization, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
