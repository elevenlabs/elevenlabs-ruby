# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Settings
      module Types
        class PatchConvAiSettingsRequest < ::Elevenlabs::Internal::Types::Model
          field :conversation_initiation_client_data_webhook, -> { ::Elevenlabs::Types::ConversationInitiationClientDataWebhook }, optional: true, nullable: false
          field :webhooks, -> { ::Elevenlabs::Types::ConvAiWebhooks }, optional: true, nullable: false
          field :can_use_mcp_servers, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
          field :rag_retention_period_days, -> { Integer }, optional: true, nullable: false
          field :conversation_embedding_retention_days, -> { Integer }, optional: true, nullable: true
          field :default_livekit_stack, -> { ::Elevenlabs::Types::LivekitStackType }, optional: true, nullable: false

          def validate!
            ::Elevenlabs::Validator.validate_integer!(rag_retention_period_days, 'rag_retention_period_days', max: 30)
            ::Elevenlabs::Validator.validate_integer!(conversation_embedding_retention_days, 'conversation_embedding_retention_days', max: 365)
          end

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
  end
end
