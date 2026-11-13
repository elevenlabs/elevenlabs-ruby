# frozen_string_literal: true

module Elevenlabs
  module Types
    module ReviewResponseModelReviewStatus
      extend ::Elevenlabs::Internal::Types::Enum

      APPROVED = :approved
      EDITS_REQUIRED = :edits_required
      REJECTED = :rejected

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
