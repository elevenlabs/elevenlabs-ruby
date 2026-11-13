# frozen_string_literal: true

module Elevenlabs
  module Types
    class UpsertOrderItemRequest < ::Elevenlabs::Internal::Types::Model
      field :item, -> { ::Elevenlabs::Types::OrderItemRequestInput }, optional: false, nullable: false
      field :item_id, -> { String }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_string!(item_id, 'item_id', pattern: /^proditem_[a-z0-9]{26}$/)
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
