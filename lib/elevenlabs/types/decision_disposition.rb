# frozen_string_literal: true

module Elevenlabs
  module Types
    module DecisionDisposition
      extend ::Elevenlabs::Internal::Types::Enum

      COMPLETED = :completed
      RETRY_QUEUED = :retry_queued
      CALLBACK_QUEUED = :callback_queued
      REDIRECT_QUEUED = :redirect_queued
      ATTENTION = :attention
      CANCELLED = :cancelled
      DO_NOT_CALL = :do_not_call
      SUPPRESSED = :suppressed
      WINDOW_SUSPENDED = :window_suspended
      ATTEMPT_CEILING_REACHED = :attempt_ceiling_reached
      CALLBACK_CEILING_REACHED = :callback_ceiling_reached
      REDIRECT_CEILING_REACHED = :redirect_ceiling_reached
      CALLBACK_TIME_INVALID = :callback_time_invalid
      REDIRECT_NUMBER_INVALID = :redirect_number_invalid
      COULDNT_PROCESS = :couldnt_process
      SUPPRESSED_DO_NOT_CALL = :suppressed_do_not_call
      SUPPRESSED_AFTER_STOP = :suppressed_after_stop
      PERMISSION_NOT_GRANTED = :permission_not_granted
      PERMISSION_DECLINED = :permission_declined
      PERMISSION_REQUEST_BLOCKED = :permission_request_blocked
      PERMISSION_EXPIRED = :permission_expired

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
