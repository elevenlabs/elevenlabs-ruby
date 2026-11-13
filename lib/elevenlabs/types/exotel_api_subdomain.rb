# frozen_string_literal: true

module Elevenlabs
  module Types
    module ExotelAPISubdomain
      extend ::Elevenlabs::Internal::Types::Enum

      API_IN_EXOTEL_COM = :'api.in.exotel.com'
      API_EXOTEL_COM = :'api.exotel.com'

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
