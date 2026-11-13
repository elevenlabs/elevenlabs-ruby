# frozen_string_literal: true

module Elevenlabs
  module Types
    class MergeProposalReview < ::Elevenlabs::Internal::Types::Model
      field :user_id, -> { String }, optional: false, nullable: false
      field :state, -> { ::Elevenlabs::Types::MergeProposalReviewState }, optional: false, nullable: false
      field :submitted_at, -> { Integer }, optional: false, nullable: false
      field :comment, -> { String }, optional: true, nullable: false
      field :reviewer_role, -> { ::Elevenlabs::Types::MergeProposalReviewReviewerRole }, optional: true, nullable: true

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
