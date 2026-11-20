# frozen_string_literal: true

module Elevenlabs
  module Types
    class WebhookSendResultResponseModel < ::Elevenlabs::Internal::Types::Model
      field :delivery_id, -> { String }, optional: false, nullable: false
      field :outcome, -> { ::Elevenlabs::Types::WebhookOutcome }, optional: false, nullable: false
      field :response_code, -> { Integer }, optional: false, nullable: true
      field :latency_ms, -> { Integer }, optional: false, nullable: true
      field :response_content_type, -> { String }, optional: false, nullable: true
      field :response_body_bytes, -> { Integer }, optional: false, nullable: true
      field :failure_origin, -> { String }, optional: false, nullable: true

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
