# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationAsrUsageModel < ::Elevenlabs::Internal::Types::Model
      field :asr_model, -> { String }, optional: true, nullable: true
      field :total_transcription_calls, -> { Integer }, optional: true, nullable: false
      field :total_audio_input_seconds, -> { Float }, optional: true, nullable: false

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
