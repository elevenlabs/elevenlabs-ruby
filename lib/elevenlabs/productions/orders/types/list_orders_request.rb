# frozen_string_literal: true

module Elevenlabs
  module Productions
    module Orders
      module Types
        class ListOrdersRequest < ::Elevenlabs::Internal::Types::Model
          field :page_size, -> { Integer }, optional: true, nullable: true

          field :offset, -> { Integer }, optional: true, nullable: true

          field :status, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::OrderState] }, optional: true, nullable: true

          field :start_date, -> { String }, optional: true, nullable: true

          field :end_date, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
