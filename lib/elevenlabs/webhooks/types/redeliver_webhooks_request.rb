# frozen_string_literal: true

module Elevenlabs
  module Webhooks
    module Types
      class RedeliverWebhooksRequest < ::Elevenlabs::Internal::Types::Model
        field :webhook_id, -> { String }, optional: false, nullable: false

        field :delivery_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
