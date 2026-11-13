# frozen_string_literal: true

module Elevenlabs
  module Types
    class GetKnowledgeBaseFileResponseModel < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :metadata, -> { ::Elevenlabs::Types::KnowledgeBaseDocumentMetadataResponseModel }, optional: false, nullable: false
      field :supported_usages, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DocumentUsageModeEnum] }, optional: false, nullable: false
      field :access_info, -> { ::Elevenlabs::Types::ResourceAccessInfo }, optional: false, nullable: false
      field :folder_parent_id, -> { String }, optional: true, nullable: true
      field :folder_path, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::KnowledgeBaseFolderPathSegmentResponseModel] }, optional: true, nullable: false
      field :type, -> { ::Elevenlabs::Types::GetKnowledgeBaseFileResponseModelType }, optional: false, nullable: false
      field :extracted_inner_html, -> { String }, optional: false, nullable: false
      field :content_format, -> { ::Elevenlabs::Types::ContentFormat }, optional: true, nullable: false
      field :filename, -> { String }, optional: false, nullable: false
      field :external_sync_info, -> { ::Elevenlabs::Types::ExternalFileSyncInfo }, optional: true, nullable: false
      field :auto_sync_info, -> { ::Elevenlabs::Types::AutoSyncInfo }, optional: true, nullable: false
      field :refresh_status, -> { ::Elevenlabs::Types::FileRefreshStatus }, optional: true, nullable: false
      field :is_frozen, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
