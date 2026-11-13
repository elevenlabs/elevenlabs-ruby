# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConvAiWebhooks < ::Elevenlabs::Internal::Types::Model
      field :post_call_webhook_id, -> { String }, optional: true, nullable: true
      field :events, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WebhookEventType] }, optional: true, nullable: false
      field :transcript_format, -> { ::Elevenlabs::Types::WebhookTranscriptFormat }, optional: true, nullable: false
      field :exclude_transcript, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :send_audio, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

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
