# frozen_string_literal: true

module Elevenlabs
  module Webhooks
    module Types
      class BodyCreateWorkspaceWebhookV1WorkspaceWebhooksPost < ::Elevenlabs::Internal::Types::Model
        field :settings, -> { ::Elevenlabs::Types::WebhookHmacSettings }, optional: false, nullable: false

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
