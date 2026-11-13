# frozen_string_literal: true

module Elevenlabs
  module Types
    module GenesysRegion
      extend ::Elevenlabs::Internal::Types::Enum

      US_EAST_1 = :us_east_1
      EU_WEST_1 = :eu_west_1
      AP_SOUTHEAST_2 = :ap_southeast_2
      AP_NORTHEAST_1 = :ap_northeast_1
      EU_CENTRAL_1 = :eu_central_1
      US_WEST_2 = :us_west_2
      CA_CENTRAL_1 = :ca_central_1
      AP_NORTHEAST_2 = :ap_northeast_2
      EU_WEST_2 = :eu_west_2
      AP_SOUTH_1 = :ap_south_1
      US_EAST_2 = :us_east_2
      SA_EAST_1 = :sa_east_1
      ME_CENTRAL_1 = :me_central_1
      AP_NORTHEAST_3 = :ap_northeast_3
      EU_CENTRAL_2 = :eu_central_2
      MX_CENTRAL_1 = :mx_central_1
      AP_SOUTHEAST_1 = :ap_southeast_1

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
