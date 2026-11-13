# frozen_string_literal: true

module Elevenlabs
  module Types
    module CreateClientAppointmentParamsSmbToolType
      extend ::Elevenlabs::Internal::Types::Enum

      CREATE_CLIENT_APPOINTMENT = :create_client_appointment

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
