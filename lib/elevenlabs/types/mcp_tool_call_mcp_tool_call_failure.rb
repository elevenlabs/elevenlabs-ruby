# frozen_string_literal: true

module Elevenlabs
  module Types
    class McpToolCallMcpToolCallFailure < ::Elevenlabs::Internal::Types::Model
      field :service_id, -> { String }, optional: false, nullable: false
      field :tool_call_id, -> { String }, optional: false, nullable: false
      field :tool_name, -> { String }, optional: false, nullable: false
      field :tool_description, -> { String }, optional: true, nullable: true
      field :parameters, -> { Object }, optional: false, nullable: false
      field :timestamp, -> { String }, optional: true, nullable: false
      field :state, -> { ::Elevenlabs::Types::McpToolCallMcpToolCall4State }, optional: false, nullable: false
      field :error_message, -> { String }, optional: false, nullable: false

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
