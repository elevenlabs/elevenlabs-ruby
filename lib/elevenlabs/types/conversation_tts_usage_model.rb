# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationTtsUsageModel < ::Elevenlabs::Internal::Types::Model
      field :primary_tts_model, -> { String }, optional: true, nullable: true
      field :total_audio_output_seconds, -> { Float }, optional: true, nullable: false
      field :total_characters, -> { Integer }, optional: true, nullable: false
      field :per_voice_usage, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationVoiceUsageModel] }, optional: true, nullable: false

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
