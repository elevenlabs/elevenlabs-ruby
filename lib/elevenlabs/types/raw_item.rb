# frozen_string_literal: true

module Elevenlabs
  module Types
    class RawItem < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: true, nullable: false
      field :price, -> { Float }, optional: true, nullable: true
      field :duration_minutes, -> { Integer }, optional: true, nullable: true

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
