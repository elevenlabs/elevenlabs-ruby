# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionServiceScrapable < ::Elevenlabs::Internal::Types::Model
      field :pricing_mode, -> { ::Elevenlabs::Types::PricingMode }, optional: true, nullable: false
      field :groups, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ReceptionGroupMembership] }, optional: true, nullable: false
      field :ungrouped_rank, -> { Integer }, optional: true, nullable: true
      field :name, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: true, nullable: false
      field :variants, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ReceptionServiceVariant] }, optional: true, nullable: false
      field :kind, -> { ::Elevenlabs::Types::ReceptionServiceKind }, optional: true, nullable: false
      field :buffer_minutes, -> { Integer }, optional: true, nullable: false
      field :service_location, -> { ::Elevenlabs::Types::ServiceLocationType }, optional: true, nullable: false
      field :add_ons, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ReceptionAddOn] }, optional: true, nullable: false
      field :max_participants, -> { Integer }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_array!(groups, 'groups', max_items: 20)
        ::Elevenlabs::Validator.validate_integer!(ungrouped_rank, 'ungrouped_rank', min: 0)
        ::Elevenlabs::Validator.validate_array!(variants, 'variants', min_items: 1, max_items: 20)
        ::Elevenlabs::Validator.validate_integer!(buffer_minutes, 'buffer_minutes', min: 0, max: 1440)
        ::Elevenlabs::Validator.validate_array!(add_ons, 'add_ons', max_items: 10)
        ::Elevenlabs::Validator.validate_integer!(max_participants, 'max_participants', min: 2, max: 200)
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
