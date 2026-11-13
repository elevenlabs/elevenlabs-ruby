# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationHistoryTranscriptToolCallAPIIntegrationWebhookDetailsOutput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::ConversationHistoryTranscriptToolCallAPIIntegrationWebhookDetailsOutputType }, optional: false, nullable: false
      field :integration_id, -> { String }, optional: false, nullable: false
      field :credential_id, -> { String }, optional: false, nullable: false
      field :integration_connection_id, -> { String }, optional: false, nullable: false
      field :webhook_details, -> { ::Elevenlabs::Types::ConversationHistoryTranscriptToolCallWebhookDetails }, optional: false, nullable: false

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
