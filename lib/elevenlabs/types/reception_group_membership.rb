# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionGroupMembership < ::Elevenlabs::Internal::Types::Model
      field :label, -> { String }, optional: false, nullable: false
      field :rank, -> { Integer }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_integer!(rank, 'rank', min: 0)
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
