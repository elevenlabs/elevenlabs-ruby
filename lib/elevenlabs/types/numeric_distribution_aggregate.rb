# frozen_string_literal: true

module Elevenlabs
  module Types
    class NumericDistributionAggregate < ::Elevenlabs::Internal::Types::Model
      field :count, -> { Integer }, optional: true, nullable: false
      field :sum, -> { Float }, optional: true, nullable: false
      field :min, -> { Float }, optional: true, nullable: true
      field :max, -> { Float }, optional: true, nullable: true

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
