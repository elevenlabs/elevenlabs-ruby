# frozen_string_literal: true

module Elevenlabs
  module Types
    module ReceptionVertical
      extend ::Elevenlabs::Internal::Types::Enum

      SALON_BARBERSHOP = :salon_barbershop
      NAIL_BEAUTY = :nail_beauty
      SPA = :spa
      MEDICAL = :medical
      VETERINARY = :veterinary
      FITNESS = :fitness
      HOME_SERVICES = :home_services
      PHOTOGRAPHY = :photography
      CONSULTING = :consulting
      RESTAURANT = :restaurant
      DENTAL = :dental
      AUTO_SERVICE = :auto_service
      TUTORING = :tutoring
      LEGAL = :legal
      REAL_ESTATE = :real_estate
      OTHER = :other

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
