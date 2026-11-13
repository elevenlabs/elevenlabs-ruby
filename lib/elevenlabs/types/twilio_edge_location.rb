# frozen_string_literal: true

module Elevenlabs
  module Types
    module TwilioEdgeLocation
      extend ::Elevenlabs::Internal::Types::Enum

      ASHBURN = :ashburn
      DUBLIN = :dublin
      FRANKFURT = :frankfurt
      SAO_PAULO = :'sao-paulo'
      SINGAPORE = :singapore
      SYDNEY = :sydney
      TOKYO = :tokyo
      UMATILLA = :umatilla
      ROAMING = :roaming

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
