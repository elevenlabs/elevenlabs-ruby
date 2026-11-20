# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionServicePromotion < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :target, -> { ::Elevenlabs::Types::PromotionTarget }, optional: true, nullable: false
      field :variant_id, -> { String }, optional: true, nullable: true
      field :add_on_id, -> { String }, optional: true, nullable: true
      field :promotional_price, -> { Float }, optional: false, nullable: false
      field :days_of_week, -> { ::Elevenlabs::Internal::Types::Array[Integer] }, optional: true, nullable: false
      field :start_date, -> { String }, optional: false, nullable: false
      field :end_date, -> { String }, optional: false, nullable: false
      field :is_active, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

      def validate!
        Validator.validate_number!(promotional_price, 'promotional_price', min: 0)
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
