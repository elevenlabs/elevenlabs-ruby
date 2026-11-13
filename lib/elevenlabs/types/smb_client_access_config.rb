# frozen_string_literal: true

module Elevenlabs
  module Types
    class SmbClientAccessConfig < ::Elevenlabs::Internal::Types::Model
      field :enable_secure_mode, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :identity_verification_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :identity_verification_email_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :identity_verification_sms_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
