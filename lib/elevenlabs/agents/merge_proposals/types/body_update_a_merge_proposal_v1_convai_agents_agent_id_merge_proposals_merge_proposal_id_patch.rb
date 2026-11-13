# frozen_string_literal: true

module Elevenlabs
  module Agents
    module MergeProposals
      module Types
        class BodyUpdateAMergeProposalV1ConvaiAgentsAgentIDMergeProposalsMergeProposalIDPatch < ::Elevenlabs::Internal::Types::Model
          field :title, -> { String }, optional: true, nullable: true
          field :description, -> { String }, optional: true, nullable: true
          field :requested_reviewer_user_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
          field :close, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

          def validate!
            ::Elevenlabs::Validator.validate_string!(title, 'title', min_length: 1, max_length: 140)
            ::Elevenlabs::Validator.validate_string!(description, 'description', max_length: 4096)
            ::Elevenlabs::Validator.validate_array!(requested_reviewer_user_ids, 'requested_reviewer_user_ids', max_items: 100)
          end

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
  end
end
