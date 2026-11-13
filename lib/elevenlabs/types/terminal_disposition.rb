# frozen_string_literal: true

module Elevenlabs
  module Types
    module TerminalDisposition
      extend ::Elevenlabs::Internal::Types::Enum

      CAMPAIGN_ENDED = :campaign_ended
      REMOVED = :removed
      DO_NOT_CALL = :do_not_call
      COMPLETED = :completed
      CANCELLED = :cancelled
      SUPPRESSED = :suppressed
      ATTEMPT_CEILING_REACHED = :attempt_ceiling_reached
      CALLBACK_CEILING_REACHED = :callback_ceiling_reached
      REDIRECT_CEILING_REACHED = :redirect_ceiling_reached
      PERMISSION_NOT_GRANTED = :permission_not_granted
      PERMISSION_DECLINED = :permission_declined
      PERMISSION_REQUEST_BLOCKED = :permission_request_blocked
      PERMISSION_EXPIRED = :permission_expired
      CALLBACK_TIME_INVALID = :callback_time_invalid
      REDIRECT_NUMBER_INVALID = :redirect_number_invalid
      COULDNT_PROCESS = :couldnt_process

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
