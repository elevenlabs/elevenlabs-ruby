# frozen_string_literal: true

module Elevenlabs
  module Types
    class TtsConversationalConfigWorkflowOverrideInput < ::Elevenlabs::Internal::Types::Model
      field :model_id, -> { ::Elevenlabs::Types::TtsConversationalModel }, optional: true, nullable: false
      field :voice_id, -> { String }, optional: true, nullable: true
      field :supported_voices, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::SupportedVoice] }, optional: true, nullable: true
      field :expressive_mode, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :suggested_audio_tags, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::SuggestedAudioTag] }, optional: true, nullable: true
      field :agent_output_audio_format, -> { ::Elevenlabs::Types::TtsOutputFormat }, optional: true, nullable: false
      field :optimize_streaming_latency, -> { ::Elevenlabs::Types::TtsOptimizeStreamingLatency }, optional: true, nullable: false
      field :stability, -> { Float }, optional: true, nullable: true
      field :speed, -> { Float }, optional: true, nullable: true
      field :similarity_boost, -> { Float }, optional: true, nullable: true
      field :clone_strength, -> { Float }, optional: true, nullable: true
      field :text_normalisation_type, -> { ::Elevenlabs::Types::TextNormalisationType }, optional: true, nullable: false
      field :pronunciation_dictionary_locators, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::PydanticPronunciationDictionaryVersionLocator] }, optional: true, nullable: true
      field :enable_phoneme_tags, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :audio_effects, -> { ::Elevenlabs::Types::EffectsSpecInput }, optional: true, nullable: false

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
