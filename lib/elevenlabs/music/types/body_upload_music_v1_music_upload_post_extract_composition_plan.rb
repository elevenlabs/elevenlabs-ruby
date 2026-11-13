# frozen_string_literal: true

module Elevenlabs
  module Music
    module Types
      module BodyUploadMusicV1MusicUploadPostExtractCompositionPlan
        extend ::Elevenlabs::Internal::Types::Union

        member -> { ::Elevenlabs::Internal::Types::Boolean }
        member -> { ::Elevenlabs::Types::MusicModelID }

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
