# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentToolResponseFullPayloadAgentToolResponseFullPayload < ::Elevenlabs::Internal::Types::Model
      field :tool_name, -> { String }, optional: false, nullable: false
      field :tool_call_id, -> { String }, optional: false, nullable: false
      field :tool_type, -> { String }, optional: false, nullable: false
      field :is_error, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :is_blocked, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :event_id, -> { Integer }, optional: false, nullable: false
      field :is_called, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :full_tool_result, -> { String }, optional: false, nullable: false
      field :truncated, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :status, -> { ::Elevenlabs::Types::AgentToolResponseFullPayloadAgentToolResponseFullPayloadStatus }, optional: true, nullable: false

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
