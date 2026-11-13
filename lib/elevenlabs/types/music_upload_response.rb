# frozen_string_literal: true

module Elevenlabs
  module Types
    class MusicUploadResponse < ::Elevenlabs::Internal::Types::Model
      field :song_id, -> { String }, optional: false, nullable: false
      field :composition_plan, -> { ::Elevenlabs::Types::MusicUploadResponseCompositionPlan }, optional: true, nullable: true
      field :words_timestamps, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WordTimestamp] }, optional: true, nullable: true
      field :waveform_visual, -> { ::Elevenlabs::Internal::Types::Array[Integer] }, optional: true, nullable: true

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
