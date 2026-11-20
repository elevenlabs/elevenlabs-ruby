# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Products
      module Types
        class ReceptionCreateProductRequest < ::Elevenlabs::Internal::Types::Model
          field :pricing_mode, -> { ::Elevenlabs::Types::PricingMode }, optional: true, nullable: false
          field :intake_questions, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ReceptionIntakeQuestion] }, optional: true, nullable: false
          field :groups, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ReceptionGroupMembership] }, optional: true, nullable: false
          field :ungrouped_rank, -> { Integer }, optional: true, nullable: true
          field :name, -> { String }, optional: false, nullable: false
          field :description, -> { String }, optional: true, nullable: false
          field :price, -> { Float }, optional: true, nullable: true
          field :is_active, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
          field :orderable, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
          field :allowed_fulfillment_types, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::OrderFulfillmentType] }, optional: true, nullable: false
          field :location_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
          field :track_quantity, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

          def validate!
            ::Elevenlabs::Validator.validate_array!(intake_questions, 'intake_questions', max_items: 10)
            ::Elevenlabs::Validator.validate_array!(groups, 'groups', max_items: 20)
            ::Elevenlabs::Validator.validate_integer!(ungrouped_rank, 'ungrouped_rank', min: 0)
            Validator.validate_number!(price, 'price', min: 0)
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
