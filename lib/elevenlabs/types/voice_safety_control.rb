# frozen_string_literal: true

module Elevenlabs
  module Types
    module VoiceSafetyControl
      extend ::Elevenlabs::Internal::Types::Enum

      NONE = :NONE
      BAN = :BAN
      CAPTCHA = :CAPTCHA
      ENTERPRISE_BAN = :ENTERPRISE_BAN
      ENTERPRISE_CAPTCHA = :ENTERPRISE_CAPTCHA

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
