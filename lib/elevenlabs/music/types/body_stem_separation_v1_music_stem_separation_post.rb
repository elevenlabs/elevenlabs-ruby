# frozen_string_literal: true

module Elevenlabs
  module Music
    module Types
      class BodyStemSeparationV1MusicStemSeparationPost < ::Elevenlabs::Internal::Types::Model
        field :file, -> { String }, optional: false, nullable: false
        field :stem_variation_id, -> { ::Elevenlabs::Music::Types::BodyStemSeparationV1MusicStemSeparationPostStemVariationID }, optional: true, nullable: false
        field :sign_with_c2pa, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
