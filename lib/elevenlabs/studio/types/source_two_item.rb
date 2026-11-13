# frozen_string_literal: true

module Elevenlabs
  module Studio
    module Types
      module SourceTwoItem
        extend ::Elevenlabs::Internal::Types::Union

        discriminant :type
        member -> { ::Elevenlabs::Types::PodcastTextSource }, key: 'text'
        member -> { ::Elevenlabs::Types::PodcastURLSource }, key: 'url'

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
