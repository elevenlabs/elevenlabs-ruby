# frozen_string_literal: true

module Elevenlabs
  module Types
    class ModelRatesResponseModel < ::Elevenlabs::Internal::Types::Model
      field :character_cost_multiplier, -> { Float }, optional: false, nullable: false
      field :cost_discount_multiplier, -> { Float }, optional: true, nullable: false

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
