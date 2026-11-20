# frozen_string_literal: true

module Elevenlabs
  module Types
    module WebhookOutcome
      extend ::Elevenlabs::Internal::Types::Enum

      DELIVERED = :delivered
      FAILED_RETRY_SCHEDULED = :failed_retry_scheduled
      FAILED_EXHAUSTED = :failed_exhausted
      FAILED_NO_RETRY = :failed_no_retry
      FAILED_RETRY_ERROR = :failed_retry_error
      DROPPED_QUEUE_FULL = :dropped_queue_full
      DROPPED_PAYLOAD_TOO_LARGE = :dropped_payload_too_large
      SKIPPED_DISABLED = :skipped_disabled
      NOT_SENT_CONFIGURATION = :not_sent_configuration

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
