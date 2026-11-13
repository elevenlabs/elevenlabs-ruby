# frozen_string_literal: true

module Elevenlabs
  module Types
    class SystemToolConfigInput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::SystemToolConfigInputType }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: true, nullable: false
      field :response_timeout_secs, -> { Integer }, optional: true, nullable: false
      field :disable_interruptions, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :interruption_mode, -> { ::Elevenlabs::Types::ToolInterruptionMode }, optional: true, nullable: false
      field :force_pre_tool_speech, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :pre_tool_speech, -> { ::Elevenlabs::Types::PreToolSpeechMode }, optional: true, nullable: false
      field :assignments, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DynamicVariableAssignment] }, optional: true, nullable: false
      field :tool_call_sound, -> { ::Elevenlabs::Types::ToolCallSoundType }, optional: true, nullable: true
      field :tool_call_sound_behavior, -> { ::Elevenlabs::Types::ToolCallSoundBehavior }, optional: true, nullable: false
      field :tool_error_handling_mode, -> { ::Elevenlabs::Types::ToolErrorHandlingMode }, optional: true, nullable: false
      field :params, -> { ::Elevenlabs::Types::SystemToolConfigInputParams }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(name, 'name', pattern: /^[a-zA-Z0-9_-]{1,64}$/)
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
