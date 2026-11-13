# frozen_string_literal: true

module Elevenlabs
  module Types
    module MusicModelID
      extend ::Elevenlabs::Internal::Types::Enum

      MUSIC_V1 = :music_v1
      MUSIC_V2 = :music_v2
      MUSIC_V2_5 = :music_v2_5

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
