# frozen_string_literal: true

module Elevenlabs
  module Types
    class CallingIntervalPolicy < ::Elevenlabs::Internal::Types::Model
      field :start, -> { String }, optional: false, nullable: false
      field :end_, -> { String }, optional: false, nullable: false, api_name: 'end'

      def validate!
        ::Elevenlabs::Validator.validate_string!(start, 'start', pattern: /^([01]\d|2[0-3]):[0-5]\d$/)
        ::Elevenlabs::Validator.validate_string!(end_, 'end', pattern: /^(([01]\d|2[0-3]):[0-5]\d|24:00)$/)
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
