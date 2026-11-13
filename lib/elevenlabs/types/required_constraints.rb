# frozen_string_literal: true

module Elevenlabs
  module Types
    class RequiredConstraints < ::Elevenlabs::Internal::Types::Model
      field :any_of, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::RequiredConstraint] }, optional: true, nullable: false
      field :all_of, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::RequiredConstraint] }, optional: true, nullable: false

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
