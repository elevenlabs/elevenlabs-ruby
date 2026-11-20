# frozen_string_literal: true

module Elevenlabs
  module Types
    class TwilioColdBlindTransferConfigOutput < ::Elevenlabs::Internal::Types::Model
      field :transfer_destination, -> { ::Elevenlabs::Types::TwilioColdBlindTransferConfigOutputTransferDestination }, optional: false, nullable: false
      field :post_dial_digits, -> { ::Elevenlabs::Types::TwilioColdBlindTransferConfigOutputPostDialDigits }, optional: false, nullable: true
      field :type, -> { ::Elevenlabs::Types::TwilioColdBlindTransferConfigOutputType }, optional: false, nullable: false

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
