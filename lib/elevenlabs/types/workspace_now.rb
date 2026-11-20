# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkspaceNow < ::Elevenlabs::Internal::Types::Model
      field :today, -> { ::Elevenlabs::Types::DateModel }, optional: false, nullable: false
      field :hour, -> { Integer }, optional: false, nullable: false
      field :minute, -> { Integer }, optional: false, nullable: false
      field :fetched_at_ms, -> { Integer }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_integer!(hour, 'hour', min: 0)
        ::Elevenlabs::Validator.validate_integer!(minute, 'minute', min: 0)
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
