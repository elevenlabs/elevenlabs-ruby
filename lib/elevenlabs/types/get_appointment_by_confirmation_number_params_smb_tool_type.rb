# frozen_string_literal: true

module Elevenlabs
  module Types
    module GetAppointmentByConfirmationNumberParamsSmbToolType
      extend ::Elevenlabs::Internal::Types::Enum

      GET_APPOINTMENT_BY_CONFIRMATION_NUMBER = :get_appointment_by_confirmation_number

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
