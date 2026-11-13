# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReviewResponseModel < ::Elevenlabs::Internal::Types::Model
      field :review_status, -> { ::Elevenlabs::Types::ReviewResponseModelReviewStatus }, optional: false, nullable: false
      field :reviewed_at_unix, -> { Integer }, optional: false, nullable: false
      field :reviewed_by, -> { String }, optional: true, nullable: true
      field :reject_reasons, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ReviewResponseModelRejectReasonsItem] }, optional: true, nullable: true
      field :scores_breakdown, -> { ::Elevenlabs::Internal::Types::Hash[String, Integer] }, optional: true, nullable: true
      field :rejected_details, -> { String }, optional: true, nullable: true
      field :explanation, -> { String }, optional: true, nullable: true

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
