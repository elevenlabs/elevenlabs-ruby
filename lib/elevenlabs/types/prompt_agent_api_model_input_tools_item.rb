# frozen_string_literal: true

module Elevenlabs
  module Types
    module PromptAgentAPIModelInputToolsItem
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::APIIntegrationWebhookToolConfigInput }, key: 'api_integration_webhook'
      member -> { ::Elevenlabs::Types::ClientToolConfigInput }, key: 'client'
      member -> { ::Elevenlabs::Types::McpToolConfigInput }, key: 'mcp'
      member -> { ::Elevenlabs::Types::SmbToolConfig }, key: 'smb'
      member -> { ::Elevenlabs::Types::SystemToolConfigInput }, key: 'system'
      member -> { ::Elevenlabs::Types::WebhookToolConfigInput }, key: 'webhook'

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
