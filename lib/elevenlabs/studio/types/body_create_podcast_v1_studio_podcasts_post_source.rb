# frozen_string_literal: true

module Elevenlabs
  module Studio
    module Types
      module BodyCreatePodcastV1StudioPodcastsPostSource
        extend ::Elevenlabs::Internal::Types::Union

        member -> { ::Elevenlabs::Types::PodcastTextSource }
        member -> { ::Elevenlabs::Types::PodcastURLSource }
        member -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Studio::Types::SourceTwoItem] }

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
