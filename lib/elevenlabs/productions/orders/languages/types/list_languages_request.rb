# frozen_string_literal: true

module Elevenlabs
  module Productions
    module Orders
      module Languages
        module Types
          class ListLanguagesRequest < ::Elevenlabs::Internal::Types::Model
            field :order_item_kind, -> { ::Elevenlabs::Types::OrderItemKind }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
