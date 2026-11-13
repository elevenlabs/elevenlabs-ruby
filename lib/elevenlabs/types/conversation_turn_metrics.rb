# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationTurnMetrics < ::Elevenlabs::Internal::Types::Model
      field :metrics, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::MetricRecord] }, optional: true, nullable: false
      field :convai_asr_provider, -> { String }, optional: true, nullable: true
      field :convai_tts_model, -> { String }, optional: true, nullable: true
      field :convai_tts_cascade, -> { String }, optional: true, nullable: true
      field :voice_id, -> { String }, optional: true, nullable: true

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
