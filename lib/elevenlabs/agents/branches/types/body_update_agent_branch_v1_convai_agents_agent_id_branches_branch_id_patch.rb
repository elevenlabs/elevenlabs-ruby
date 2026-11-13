# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Branches
      module Types
        class BodyUpdateAgentBranchV1ConvaiAgentsAgentIDBranchesBranchIDPatch < ::Elevenlabs::Internal::Types::Model
          field :name, -> { String }, optional: true, nullable: true
          field :description, -> { String }, optional: true, nullable: true
          field :is_archived, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
          field :protection_status, -> { ::Elevenlabs::Types::BranchProtectionStatus }, optional: true, nullable: false
          field :auto_rebase, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

          def validate!
            ::Elevenlabs::Validator.validate_string!(name, 'name', min_length: 1, max_length: 140)
            ::Elevenlabs::Validator.validate_string!(description, 'description', max_length: 4096)
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
