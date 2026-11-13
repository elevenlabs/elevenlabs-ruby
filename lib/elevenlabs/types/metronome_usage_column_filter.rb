# frozen_string_literal: true

module Elevenlabs
  module Types
    class MetronomeUsageColumnFilter < ::Elevenlabs::Internal::Types::Model
      field :column, -> { ::Elevenlabs::Types::MetronomeUsageColumnFilterColumn }, optional: false, nullable: false
      field :operation, -> { ::Elevenlabs::Types::MetronomeUsageColumnFilterOperation }, optional: false, nullable: false
      field :values, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::MetronomeUsageColumnFilterValuesItem] }, optional: false, nullable: false

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
