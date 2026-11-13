# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentBranchResponse < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :agent_id, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :created_at, -> { Integer }, optional: false, nullable: false
      field :last_committed_at, -> { Integer }, optional: false, nullable: false
      field :is_archived, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :protection_status, -> { ::Elevenlabs::Types::BranchProtectionStatus }, optional: true, nullable: false
      field :auto_rebase, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :sync_status, -> { ::Elevenlabs::Types::BranchSyncStatus }, optional: true, nullable: false
      field :access_info, -> { ::Elevenlabs::Types::ResourceAccessInfo }, optional: true, nullable: false
      field :current_live_percentage, -> { Float }, optional: true, nullable: false
      field :parent_branch, -> { ::Elevenlabs::Types::AgentBranchBasicInfo }, optional: true, nullable: true
      field :most_recent_versions, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AgentVersionMetadata] }, optional: true, nullable: false

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
