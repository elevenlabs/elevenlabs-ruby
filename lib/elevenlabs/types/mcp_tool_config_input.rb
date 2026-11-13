# frozen_string_literal: true

module Elevenlabs
  module Types
    class McpToolConfigInput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::McpToolConfigInputType }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :response_timeout_secs, -> { Integer }, optional: true, nullable: false
      field :disable_interruptions, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :interruption_mode, -> { ::Elevenlabs::Types::ToolInterruptionMode }, optional: true, nullable: false
      field :force_pre_tool_speech, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :pre_tool_speech, -> { ::Elevenlabs::Types::PreToolSpeechMode }, optional: true, nullable: false
      field :assignments, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DynamicVariableAssignment] }, optional: true, nullable: false
      field :tool_call_sound, -> { ::Elevenlabs::Types::ToolCallSoundType }, optional: true, nullable: false
      field :tool_call_sound_behavior, -> { ::Elevenlabs::Types::ToolCallSoundBehavior }, optional: true, nullable: false
      field :tool_error_handling_mode, -> { ::Elevenlabs::Types::ToolErrorHandlingMode }, optional: true, nullable: false
      field :integration_type, -> { ::Elevenlabs::Types::IntegrationType }, optional: false, nullable: false
      field :parameters, -> { ::Elevenlabs::Types::ObjectJSONSchemaPropertyInput }, optional: true, nullable: false
      field :approval_policy, -> { ::Elevenlabs::Types::McpApprovalPolicy }, optional: true, nullable: false
      field :mcp_tool_name, -> { String }, optional: false, nullable: false
      field :mcp_tool_description, -> { String }, optional: false, nullable: false
      field :mcp_server_id, -> { String }, optional: false, nullable: false
      field :mcp_server_name, -> { String }, optional: false, nullable: false
      field :mcp_input_schema, -> { Object }, optional: true, nullable: true
      field :execution_mode, -> { ::Elevenlabs::Types::ToolExecutionMode }, optional: true, nullable: false
      field :input_overrides, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Agents::Types::McpToolConfigInputInputOverridesValue] }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_string!(name, 'name', pattern: /^[a-zA-Z0-9_-]{1,64}$/)
        ::Elevenlabs::Validator.validate_integer!(response_timeout_secs, 'response_timeout_secs', min: 5, max: 300)
      end

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
