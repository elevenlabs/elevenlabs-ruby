# frozen_string_literal: true

module Elevenlabs
  module Types
    class DubbingTranscriptUtterance < ::Elevenlabs::Internal::Types::Model
      field :text, -> { String }, optional: true, nullable: false
      field :speaker_id, -> { String }, optional: true, nullable: false
      field :start_s, -> { Float }, optional: true, nullable: false
      field :end_s, -> { Float }, optional: true, nullable: false
      field :words, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DubbingTranscriptWord] }, optional: true, nullable: false

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
