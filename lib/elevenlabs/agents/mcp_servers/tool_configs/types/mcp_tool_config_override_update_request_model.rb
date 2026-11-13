# frozen_string_literal: true

module Elevenlabs
  module Agents
    module McpServers
      module ToolConfigs
        module Types
          class McpToolConfigOverrideUpdateRequestModel < ::Elevenlabs::Internal::Types::Model
            field :force_pre_tool_speech, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
            field :pre_tool_speech, -> { ::Elevenlabs::Types::PreToolSpeechMode }, optional: true, nullable: false
            field :disable_interruptions, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
            field :interruption_mode, -> { ::Elevenlabs::Types::ToolInterruptionMode }, optional: true, nullable: false
            field :tool_call_sound, -> { ::Elevenlabs::Agents::McpServers::ToolConfigs::Types::McpToolConfigOverrideUpdateRequestModelToolCallSound }, optional: true, nullable: true
            field :tool_call_sound_behavior, -> { ::Elevenlabs::Types::ToolCallSoundBehavior }, optional: true, nullable: false
            field :execution_mode, -> { ::Elevenlabs::Types::ToolExecutionMode }, optional: true, nullable: false
            field :response_timeout_secs, -> { Integer }, optional: true, nullable: true
            field :assignments, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DynamicVariableAssignment] }, optional: true, nullable: true
            field :input_overrides, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Agents::McpServers::ToolConfigs::Types::McpToolConfigOverrideUpdateRequestModelInputOverridesValue] }, optional: true, nullable: true
            field :response_mocks, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ToolResponseMockConfigInput] }, optional: true, nullable: true

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
    end
  end
end
