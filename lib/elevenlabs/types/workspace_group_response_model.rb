# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkspaceGroupResponseModel < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :members, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :permissions, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WorkspaceGroupPermission] }, optional: false, nullable: true
      field :group_usage_limit, -> { ::Elevenlabs::Types::WorkspaceGroupResponseModelGroupUsageLimit }, optional: true, nullable: true
      field :group_pvc_limit, -> { ::Elevenlabs::Types::WorkspaceGroupResponseModelGroupPvcLimit }, optional: true, nullable: true
      field :group_concurrency_limit, -> { ::Elevenlabs::Types::WorkspaceGroupResponseModelGroupConcurrencyLimit }, optional: true, nullable: true
      field :group_dubbing_concurrency_limit, -> { ::Elevenlabs::Types::WorkspaceGroupResponseModelGroupDubbingConcurrencyLimit }, optional: true, nullable: true
      field :group_music_concurrency_limit, -> { ::Elevenlabs::Types::WorkspaceGroupResponseModelGroupMusicConcurrencyLimit }, optional: true, nullable: true
      field :character_count, -> { Integer }, optional: true, nullable: true
      field :is_scim_synced, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :scim_group, -> { ::Elevenlabs::Types::SCIMGroupResponseModel }, optional: true, nullable: true
      field :scim_frozen, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
