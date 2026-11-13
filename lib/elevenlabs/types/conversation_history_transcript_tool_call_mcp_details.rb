# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationHistoryTranscriptToolCallMcpDetails < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::ConversationHistoryTranscriptToolCallMcpDetailsType }, optional: true, nullable: false
      field :mcp_server_id, -> { String }, optional: false, nullable: false
      field :mcp_server_name, -> { String }, optional: false, nullable: false
      field :integration_type, -> { String }, optional: false, nullable: false
      field :parameters, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :approval_policy, -> { String }, optional: false, nullable: false
      field :requires_approval, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :mcp_tool_name, -> { String }, optional: true, nullable: false
      field :mcp_tool_description, -> { String }, optional: true, nullable: false

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
