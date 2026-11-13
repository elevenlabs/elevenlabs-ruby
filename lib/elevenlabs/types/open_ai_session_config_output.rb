# frozen_string_literal: true

module Elevenlabs
  module Types
    class OpenAiSessionConfigOutput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::OpenAiSessionConfigOutputType }, optional: true, nullable: false
      field :model, -> { ::Elevenlabs::Types::RealtimeModel }, optional: true, nullable: false
      field :instructions, -> { String }, optional: true, nullable: false
      field :output_modalities, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :audio, -> { ::Elevenlabs::Types::OpenAiAudioConfigOutput }, optional: true, nullable: false
      field :tools, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::OpenAiSessionConfigOutputToolsItem] }, optional: true, nullable: false
      field :tool_choice, -> { ::Elevenlabs::Types::OpenAiSessionConfigOutputToolChoice }, optional: true, nullable: false
      field :temperature, -> { Float }, optional: true, nullable: false
      field :max_response_output_tokens, -> { ::Elevenlabs::Types::OpenAiSessionConfigOutputMaxResponseOutputTokens }, optional: true, nullable: false
      field :max_duration_seconds, -> { Integer }, optional: true, nullable: false
      field :tracing, -> { ::Elevenlabs::Types::OpenAiSessionConfigOutputTracing }, optional: true, nullable: true

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
