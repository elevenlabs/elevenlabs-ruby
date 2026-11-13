# frozen_string_literal: true

module Elevenlabs
  module Webhooks
    module Types
      class ListWebhooksRequest < ::Elevenlabs::Internal::Types::Model
        field :include_usages, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      end
    end
  end
end
