# frozen_string_literal: true

module Elevenlabs
  module Productions
    module Orders
      module Media
        module Types
          class GetMediaRequest < ::Elevenlabs::Internal::Types::Model
            field :order_id, -> { String }, optional: false, nullable: false

            field :media_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
