# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Products
      module Stock
        module Types
          class ReceptionUpdateProductStockRequest < ::Elevenlabs::Internal::Types::Model
            field :product_id, -> { String }, optional: false, nullable: false
            field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
            field :location_id, -> { String }, optional: false, nullable: false
            field :on_hand, -> { Integer }, optional: false, nullable: false
            field :expected_on_hand, -> { Integer }, optional: false, nullable: false

            def validate!
              ::Elevenlabs::Validator.validate_integer!(on_hand, 'on_hand', min: 0)
              ::Elevenlabs::Validator.validate_integer!(expected_on_hand, 'expected_on_hand', min: 0)
            end

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
  end
end
