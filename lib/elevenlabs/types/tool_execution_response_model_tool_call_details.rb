# frozen_string_literal: true

module Elevenlabs
  module Types
    module ToolExecutionResponseModelToolCallDetails
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::ConversationHistoryTranscriptToolCallAPIIntegrationWebhookDetailsOutput }, key: 'api_integration_webhook'
      member -> { ::Elevenlabs::Types::ConversationHistoryTranscriptToolCallClientDetails }, key: 'client'
      member -> { ::Elevenlabs::Types::ConversationHistoryTranscriptToolCallMcpDetails }, key: 'mcp'
      member -> { ::Elevenlabs::Types::ConversationHistoryTranscriptToolCallWebhookDetails }, key: 'webhook'

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
