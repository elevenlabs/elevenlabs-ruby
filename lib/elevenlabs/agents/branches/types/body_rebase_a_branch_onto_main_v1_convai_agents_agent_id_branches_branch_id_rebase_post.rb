# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Branches
      module Types
        class BodyRebaseABranchOntoMainV1ConvaiAgentsAgentIDBranchesBranchIDRebasePost < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false
          field :branch_id, -> { String }, optional: false, nullable: false
          field :source_branch_id, -> { String }, optional: true, nullable: true
          field :conflict_resolutions, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConflictResolution] }, optional: true, nullable: true
          field :branch_tip_id, -> { String }, optional: true, nullable: true
          field :source_tip_id, -> { String }, optional: true, nullable: true

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
