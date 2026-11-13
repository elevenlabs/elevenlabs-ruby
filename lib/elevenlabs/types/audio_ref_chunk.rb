# frozen_string_literal: true

module Elevenlabs
  module Types
    class AudioRefChunk < ::Elevenlabs::Internal::Types::Model
      field :song_id, -> { String }, optional: false, nullable: false
      field :range, -> { ::Elevenlabs::Types::TimeRange }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(song_id, 'song_id', min_length: 1, max_length: 100)
      end

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
