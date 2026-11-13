# frozen_string_literal: true

module Elevenlabs
  module Types
    class MultipartMusicResponse < ::Elevenlabs::Internal::Types::Model
      field :metadata, -> { ::Elevenlabs::Types::DetailedMusicResponse }, optional: false, nullable: false
      field :audio, -> { String }, optional: false, nullable: false

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
