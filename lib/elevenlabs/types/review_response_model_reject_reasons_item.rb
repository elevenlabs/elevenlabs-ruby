# frozen_string_literal: true

module Elevenlabs
  module Types
    module ReviewResponseModelRejectReasonsItem
      extend ::Elevenlabs::Internal::Types::Enum

      LACKS_STRUCTURE = :lacks_structure
      DOESNT_OPEN = :doesnt_open
      NOT_LITERARY_WORK = :not_literary_work
      LANGUAGE_NOT_SUPPORTED = :language_not_supported
      TOO_SHORT = :too_short
      DUPLICATE = :duplicate
      PROMOTIONAL = :promotional
      FORMATTING_ISSUES = :formatting_issues
      LOW_QUALITY = :low_quality
      METADATA_INCOMPLETE = :metadata_incomplete
      METADATA_INACCURATE = :metadata_inaccurate
      TYPOS = :typos
      REVIEW_ERROR = :review_error
      SPAM = :spam
      LEGAL_VIOLATION = :legal_violation
      CONTENT_POLICY = :content_policy
      PUBLIC_DOMAIN = :public_domain
      OTHER = :other

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
