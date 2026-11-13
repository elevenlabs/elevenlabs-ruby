# frozen_string_literal: true

module Elevenlabs
  module Types
    class ToolMockConfig < ::Elevenlabs::Internal::Types::Model
      field :default_return_value, -> { String }, optional: true, nullable: false
      field :default_is_error, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
