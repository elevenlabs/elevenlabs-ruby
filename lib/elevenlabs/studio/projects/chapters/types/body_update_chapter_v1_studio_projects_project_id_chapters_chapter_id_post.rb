# frozen_string_literal: true

module Elevenlabs
  module Studio
    module Projects
      module Chapters
        module Types
          class BodyUpdateChapterV1StudioProjectsProjectIDChaptersChapterIDPost < ::Elevenlabs::Internal::Types::Model
            field :name, -> { String }, optional: true, nullable: true
            field :content, -> { ::Elevenlabs::Types::ChapterContentInputModel }, optional: true, nullable: true

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
end
