# frozen_string_literal: true

module Elevenlabs
  module Types
    class McpToolApprovalStatus < ::Elevenlabs::Internal::Types::Model
      field :tool_id, -> { String }, optional: false, nullable: false
      field :state, -> { ::Elevenlabs::Types::McpToolApprovalState }, optional: false, nullable: false
      field :approval_policy, -> { ::Elevenlabs::Types::McpToolApprovalPolicy }, optional: true, nullable: false
      field :approved_definition, -> { ::Elevenlabs::Types::McpApprovedToolDefinition }, optional: true, nullable: true

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
