# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentMergeProposalResponse < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :agent_id, -> { String }, optional: false, nullable: false
      field :source_branch_id, -> { String }, optional: false, nullable: false
      field :target_branch_id, -> { String }, optional: false, nullable: false
      field :source_tip_version_id_at_creation, -> { String }, optional: false, nullable: false
      field :title, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: true, nullable: false
      field :requested_reviewer_user_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :reviews, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::MergeProposalReview] }, optional: true, nullable: false
      field :comments, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::MergeProposalComment] }, optional: true, nullable: false
      field :outcome, -> { ::Elevenlabs::Types::AgentMergeProposalResponseOutcome }, optional: true, nullable: false
      field :created_at, -> { Integer }, optional: false, nullable: false
      field :updated_at, -> { Integer }, optional: false, nullable: false
      field :author_user_id, -> { String }, optional: true, nullable: true
      field :access_info, -> { ::Elevenlabs::Types::ResourceAccessInfo }, optional: true, nullable: false

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
