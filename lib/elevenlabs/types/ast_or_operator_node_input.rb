# frozen_string_literal: true

module Elevenlabs
  module Types
    class AstOrOperatorNodeInput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::AstOrOperatorNodeInputType }, optional: true, nullable: false
      field :children, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AstNodeInput] }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(children, 'children', min_items: 2)
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
