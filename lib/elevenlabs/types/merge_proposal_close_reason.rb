# frozen_string_literal: true

module Elevenlabs
  module Types
    module MergeProposalCloseReason
      extend ::Elevenlabs::Internal::Types::Enum

      WITHDRAWN = :withdrawn
      REJECTED = :rejected
      BRANCH_ARCHIVED = :branch_archived

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
