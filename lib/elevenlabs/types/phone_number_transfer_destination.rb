# frozen_string_literal: true

module Elevenlabs
  module Types
    class PhoneNumberTransferDestination < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::PhoneNumberTransferDestinationType }, optional: true, nullable: false
      field :phone_number, -> { String }, optional: false, nullable: false

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
