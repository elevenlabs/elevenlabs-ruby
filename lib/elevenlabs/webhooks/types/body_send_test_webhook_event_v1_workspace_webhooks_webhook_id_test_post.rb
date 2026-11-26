# frozen_string_literal: true

module Elevenlabs
  module Webhooks
    module Types
      class BodySendTestWebhookEventV1WorkspaceWebhooksWebhookIDTestPost < ::Elevenlabs::Internal::Types::Model
        field :webhook_id, -> { String }, optional: false, nullable: false
        field :webhook_type, -> { ::Elevenlabs::Types::WebhookTypes }, optional: false, nullable: false

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
