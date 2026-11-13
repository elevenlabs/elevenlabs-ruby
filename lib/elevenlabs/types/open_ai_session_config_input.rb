# frozen_string_literal: true

module Elevenlabs
  module Types
    class OpenAiSessionConfigInput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::OpenAiSessionConfigInputType }, optional: true, nullable: false
      field :model, -> { ::Elevenlabs::Types::RealtimeModel }, optional: true, nullable: false
      field :instructions, -> { String }, optional: true, nullable: false
      field :output_modalities, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :audio, -> { ::Elevenlabs::Types::OpenAiAudioConfigInput }, optional: true, nullable: false
      field :tools, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::OpenAiSessionConfigInputToolsItem] }, optional: true, nullable: false
      field :tool_choice, -> { ::Elevenlabs::Types::OpenAiSessionConfigInputToolChoice }, optional: true, nullable: false
      field :temperature, -> { Float }, optional: true, nullable: false
      field :max_response_output_tokens, -> { ::Elevenlabs::Types::OpenAiSessionConfigInputMaxResponseOutputTokens }, optional: true, nullable: false
      field :max_duration_seconds, -> { Integer }, optional: true, nullable: false
      field :turn_detection, -> { ::Elevenlabs::Types::OpenAiSessionConfigInputTurnDetection }, optional: true, nullable: true
      field :tracing, -> { ::Elevenlabs::Types::OpenAiSessionConfigInputTracing }, optional: true, nullable: true
      field :include, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :parallel_tool_calls, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :reasoning, -> { Object }, optional: true, nullable: true
      field :truncation, -> { ::Elevenlabs::Types::OpenAiSessionConfigInputTruncation }, optional: true, nullable: true
      field :prompt, -> { Object }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_integer!(max_duration_seconds, 'max_duration_seconds', min: 60, max: 7200)
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
