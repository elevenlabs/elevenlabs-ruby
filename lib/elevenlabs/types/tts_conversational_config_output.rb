# frozen_string_literal: true

module Elevenlabs
  module Types
    class TtsConversationalConfigOutput < ::Elevenlabs::Internal::Types::Model
      field :model_id, -> { ::Elevenlabs::Types::TtsConversationalModel }, optional: true, nullable: false
      field :voice_id, -> { String }, optional: true, nullable: false
      field :supported_voices, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::SupportedVoice] }, optional: true, nullable: false
      field :expressive_mode, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :suggested_audio_tags, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::SuggestedAudioTag] }, optional: true, nullable: false
      field :agent_output_audio_format, -> { ::Elevenlabs::Types::TtsOutputFormat }, optional: true, nullable: false
      field :optimize_streaming_latency, -> { ::Elevenlabs::Types::TtsOptimizeStreamingLatency }, optional: true, nullable: false
      field :stability, -> { Float }, optional: true, nullable: false
      field :speed, -> { Float }, optional: true, nullable: false
      field :similarity_boost, -> { Float }, optional: true, nullable: false
      field :clone_strength, -> { Float }, optional: true, nullable: false
      field :text_normalisation_type, -> { ::Elevenlabs::Types::TextNormalisationType }, optional: true, nullable: false
      field :pronunciation_dictionary_locators, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::PydanticPronunciationDictionaryVersionLocator] }, optional: true, nullable: false
      field :enable_phoneme_tags, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :audio_effects, -> { ::Elevenlabs::Types::EffectsSpecOutput }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(suggested_audio_tags, 'suggested_audio_tags', max_items: 20)
        Validator.validate_number!(stability, 'stability', min: 0, max: 1)
        Validator.validate_number!(speed, 'speed', min: 0.7, max: 1.2)
        Validator.validate_number!(similarity_boost, 'similarity_boost', min: 0, max: 1)
        Validator.validate_number!(clone_strength, 'clone_strength', min: 0, max: 1)
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
