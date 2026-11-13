# frozen_string_literal: true

module Elevenlabs
  module Types
    class DubbingTranscriptsResponseModel < ::Elevenlabs::Internal::Types::Model
      field :transcript_format, -> { ::Elevenlabs::Types::DubbingTranscriptsResponseModelTranscriptFormat }, optional: false, nullable: false
      field :srt, -> { String }, optional: true, nullable: true
      field :webvtt, -> { String }, optional: true, nullable: true
      field :json, -> { ::Elevenlabs::Types::DubbingTranscript }, optional: true, nullable: true

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
