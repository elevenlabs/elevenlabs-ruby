# frozen_string_literal: true

module Elevenlabs
  module Types
    module SLAMetric
      extend ::Elevenlabs::Internal::Types::Enum

      FIRST_RESPONSE = :first_response
      RESOLUTION = :resolution
      NEXT_RESPONSE = :next_response

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
