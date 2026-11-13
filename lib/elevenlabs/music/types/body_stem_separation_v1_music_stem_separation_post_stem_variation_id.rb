# frozen_string_literal: true

module Elevenlabs
  module Music
    module Types
      module BodyStemSeparationV1MusicStemSeparationPostStemVariationID
        extend ::Elevenlabs::Internal::Types::Enum

        TWO_STEMS_V1 = :two_stems_v1
        SIX_STEMS_V1 = :six_stems_v1

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
