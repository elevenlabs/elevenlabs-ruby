# frozen_string_literal: true

module Elevenlabs
  module Types
    module GetBookingSlugStatusParamsSmbToolType
      extend ::Elevenlabs::Internal::Types::Enum

      GET_BOOKING_SLUG_STATUS = :get_booking_slug_status

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
