# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Subscriptions
      module Types
        class CancelPendingDowngradeSubscriptionsRequest < ::Elevenlabs::Internal::Types::Model
          field :workspace_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
