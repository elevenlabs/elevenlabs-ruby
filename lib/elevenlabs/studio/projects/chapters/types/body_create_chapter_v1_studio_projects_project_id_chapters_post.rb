# frozen_string_literal: true

module Elevenlabs
  module Studio
    module Projects
      module Chapters
        module Types
          class BodyCreateChapterV1StudioProjectsProjectIDChaptersPost < ::Elevenlabs::Internal::Types::Model
            field :name, -> { String }, optional: false, nullable: false
            field :from_url, -> { String }, optional: true, nullable: true

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
