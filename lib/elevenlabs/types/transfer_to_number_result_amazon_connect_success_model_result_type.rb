# frozen_string_literal: true

module Elevenlabs
  module Types
    module TransferToNumberResultAmazonConnectSuccessModelResultType
      extend ::Elevenlabs::Internal::Types::Enum

      TRANSFER_TO_NUMBER_AMAZON_CONNECT_SUCCESS = :transfer_to_number_amazon_connect_success

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
