# frozen_string_literal: true

module Elevenlabs
  module Types
    module ReviewStatus
      extend ::Elevenlabs::Internal::Types::Enum

      NOT_REQUESTED = :not_requested
      PENDING = :pending
      DECLINED = :declined
      DECLINED_RESUBMITTABLE = :declined_resubmittable
      ALLOWED = :allowed
      ALLOWED_WITH_CHANGES = :allowed_with_changes

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
