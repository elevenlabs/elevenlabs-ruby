# frozen_string_literal: true

module Elevenlabs
  module Types
    class AstLessThanOperatorNodeOutput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::AstLessThanOperatorNodeOutputType }, optional: false, nullable: false
      field :left, -> { ::Elevenlabs::Types::AstNodeOutput }, optional: false, nullable: false
      field :right, -> { ::Elevenlabs::Types::AstNodeOutput }, optional: false, nullable: false

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
