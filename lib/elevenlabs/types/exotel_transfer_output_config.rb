# frozen_string_literal: true

module Elevenlabs
  module Types
    module ExotelTransferOutputConfig
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::ExotelColdBlindTransferConfigOutput }, key: 'exotel_cold_blind_transfer'
      member -> { ::Elevenlabs::Types::ExotelWarmTransferConfigOutput }, key: 'exotel_warm_transfer'

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
