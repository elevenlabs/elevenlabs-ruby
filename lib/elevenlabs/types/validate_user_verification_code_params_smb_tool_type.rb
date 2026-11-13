# frozen_string_literal: true

module Elevenlabs
  module Types
    module ValidateUserVerificationCodeParamsSmbToolType
      extend ::Elevenlabs::Internal::Types::Enum

      VALIDATE_USER_VERIFICATION_CODE = :validate_user_verification_code

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
