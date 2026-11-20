# frozen_string_literal: true

module Elevenlabs
  module Types
    class ContextualUpdateInputItem < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::ContextualUpdateInputItemType }, optional: false, nullable: false
      field :text, -> { String }, optional: false, nullable: false
      field :context_id, -> { String }, optional: false, nullable: false
      field :placement, -> { ::Elevenlabs::Types::ContextualUpdatePlacement }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(text, 'text', min_length: 1)
        ::Elevenlabs::Validator.validate_string!(context_id, 'context_id', min_length: 1)
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
