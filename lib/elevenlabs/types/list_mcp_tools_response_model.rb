# frozen_string_literal: true

module Elevenlabs
  module Types
    class ListMcpToolsResponseModel < ::Elevenlabs::Internal::Types::Model
      field :success, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :tools, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::Tool] }, optional: false, nullable: false
      field :tool_approval_statuses, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::McpToolApprovalStatus] }, optional: true, nullable: false
      field :error_message, -> { String }, optional: true, nullable: true

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
