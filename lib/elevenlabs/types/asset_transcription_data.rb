# frozen_string_literal: true

module Elevenlabs
  module Types
    class AssetTranscriptionData < ::Elevenlabs::Internal::Types::Model
      field :language_code, -> { String }, optional: false, nullable: false
      field :text, -> { String }, optional: false, nullable: false
      field :words, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :word_start_times_ms, -> { ::Elevenlabs::Internal::Types::Array[Integer] }, optional: false, nullable: false
      field :word_end_times_ms, -> { ::Elevenlabs::Internal::Types::Array[Integer] }, optional: false, nullable: false
      field :word_speaker_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false

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
