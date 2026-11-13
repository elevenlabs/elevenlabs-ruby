# frozen_string_literal: true

module Elevenlabs
  module Types
    class McpServerConfigInput < ::Elevenlabs::Internal::Types::Model
      field :approval_policy, -> { ::Elevenlabs::Types::McpApprovalPolicy }, optional: true, nullable: false
      field :tool_approval_hashes, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::McpToolApprovalHash] }, optional: true, nullable: false
      field :transport, -> { ::Elevenlabs::Types::McpServerTransport }, optional: true, nullable: false
      field :url, -> { ::Elevenlabs::Types::McpServerConfigInputURL }, optional: false, nullable: false
      field :secret_token, -> { ::Elevenlabs::Types::McpServerConfigInputSecretToken }, optional: true, nullable: true
      field :request_headers, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Agents::McpServers::Types::McpServerConfigInputRequestHeadersValue] }, optional: true, nullable: false
      field :request_meta, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Agents::McpServers::Types::McpServerConfigInputRequestMetaValue] }, optional: true, nullable: false
      field :auth_connection, -> { ::Elevenlabs::Types::McpServerConfigInputAuthConnection }, optional: true, nullable: true
      field :name, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: true, nullable: false
      field :force_pre_tool_speech, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :pre_tool_speech, -> { ::Elevenlabs::Types::PreToolSpeechMode }, optional: true, nullable: false
      field :disable_interruptions, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :interruption_mode, -> { ::Elevenlabs::Types::ToolInterruptionMode }, optional: true, nullable: false
      field :tool_call_sound, -> { ::Elevenlabs::Types::ToolCallSoundType }, optional: true, nullable: false
      field :tool_call_sound_behavior, -> { ::Elevenlabs::Types::ToolCallSoundBehavior }, optional: true, nullable: false
      field :execution_mode, -> { ::Elevenlabs::Types::ToolExecutionMode }, optional: true, nullable: false
      field :response_timeout_secs, -> { Integer }, optional: true, nullable: false
      field :tool_config_overrides, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::McpToolConfigOverrideInput] }, optional: true, nullable: false
      field :disable_compression, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

      def validate!
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
