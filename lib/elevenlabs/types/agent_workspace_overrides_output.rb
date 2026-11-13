# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentWorkspaceOverridesOutput < ::Elevenlabs::Internal::Types::Model
      field :conversation_initiation_client_data_webhook, -> { ::Elevenlabs::Types::ConversationInitiationClientDataWebhook }, optional: true, nullable: false
      field :webhooks, -> { ::Elevenlabs::Types::ConvAiWebhooks }, optional: true, nullable: false

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
