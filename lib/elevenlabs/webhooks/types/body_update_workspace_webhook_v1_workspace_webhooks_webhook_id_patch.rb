# frozen_string_literal: true

module Elevenlabs
  module Webhooks
    module Types
      class BodyUpdateWorkspaceWebhookV1WorkspaceWebhooksWebhookIDPatch < ::Elevenlabs::Internal::Types::Model
        field :is_disabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
        field :name, -> { String }, optional: false, nullable: false
        field :retry_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
        field :request_headers, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: true
        field :events, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WorkspaceWebhookEventType] }, optional: true, nullable: true

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
