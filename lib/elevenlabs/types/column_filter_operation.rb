# frozen_string_literal: true

module Elevenlabs
  module Types
    module ColumnFilterOperation
      extend ::Elevenlabs::Internal::Types::Enum

      IN_ = :in
      NOT_IN = :not_in
      LE = :le
      GE = :ge
      LT = :lt
      GT = :gt
      EQ = :eq
      NEQ = :neq

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
