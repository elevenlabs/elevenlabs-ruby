# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionIdentityVerificationConfig < ::Elevenlabs::Internal::Types::Model
      field :enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :channels, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ReceptionNotificationChannel] }, optional: true, nullable: false
      field :sms_phone_number_id, -> { String }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_array!(channels, 'channels', unique_items: true)
      end

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
