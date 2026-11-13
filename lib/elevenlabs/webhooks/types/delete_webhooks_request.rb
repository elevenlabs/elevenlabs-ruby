# frozen_string_literal: true

module Elevenlabs
  module Webhooks
    module Types
      class DeleteWebhooksRequest < ::Elevenlabs::Internal::Types::Model
        field :webhook_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
