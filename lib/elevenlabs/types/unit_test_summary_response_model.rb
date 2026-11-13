# frozen_string_literal: true

module Elevenlabs
  module Types
    class UnitTestSummaryResponseModel < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :access_info, -> { ::Elevenlabs::Types::ResourceAccessInfo }, optional: true, nullable: false
      field :created_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :last_updated_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :type, -> { ::Elevenlabs::Types::TestType }, optional: false, nullable: false
      field :entity_type, -> { ::Elevenlabs::Types::AgentTestEntityType }, optional: true, nullable: false
      field :folder_parent_id, -> { String }, optional: true, nullable: true
      field :folder_path, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AgentTestFolderPathSegmentResponseModel] }, optional: true, nullable: false
      field :children_count, -> { Integer }, optional: true, nullable: true
      field :conversation_initiation_source, -> { ::Elevenlabs::Types::ConversationInitiationSource }, optional: true, nullable: false

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
