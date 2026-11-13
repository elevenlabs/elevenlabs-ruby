# frozen_string_literal: true

module Elevenlabs
  module Types
    module OptInSmsReminderParamsSmbToolType
      extend ::Elevenlabs::Internal::Types::Enum

      OPT_IN_SMS_REMINDER = :opt_in_sms_reminder

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
