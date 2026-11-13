# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationInitiationClientDataWebhook < ::Elevenlabs::Internal::Types::Model
      field :url, -> { String }, optional: false, nullable: false
      field :request_headers, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Voices::Settings::Types::ConversationInitiationClientDataWebhookRequestHeadersValue] }, optional: false, nullable: false

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
