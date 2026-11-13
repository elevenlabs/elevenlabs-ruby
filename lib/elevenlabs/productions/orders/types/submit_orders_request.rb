# frozen_string_literal: true

module Elevenlabs
  module Productions
    module Orders
      module Types
        class SubmitOrdersRequest < ::Elevenlabs::Internal::Types::Model
          field :order_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
