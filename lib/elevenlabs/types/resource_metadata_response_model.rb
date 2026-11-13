# frozen_string_literal: true

module Elevenlabs
  module Types
    class ResourceMetadataResponseModel < ::Elevenlabs::Internal::Types::Model
      field :resource_id, -> { String }, optional: false, nullable: false
      field :resource_name, -> { String }, optional: false, nullable: true
      field :resource_type, -> { ::Elevenlabs::Types::WorkspaceResourceType }, optional: false, nullable: false
      field :creator_user_id, -> { String }, optional: false, nullable: true
      field :anonymous_access_level_override, -> { ::Elevenlabs::Types::ResourceMetadataResponseModelAnonymousAccessLevelOverride }, optional: false, nullable: true
      field :role_to_group_ids, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Internal::Types::Array[String]] }, optional: false, nullable: false
      field :share_options, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ShareOptionResponseModel] }, optional: false, nullable: false

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
