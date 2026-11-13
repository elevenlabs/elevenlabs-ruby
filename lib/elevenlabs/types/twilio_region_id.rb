# frozen_string_literal: true

module Elevenlabs
  module Types
    module TwilioRegionID
      extend ::Elevenlabs::Internal::Types::Enum

      US1 = :us1
      IE1 = :ie1
      AU1 = :au1

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
