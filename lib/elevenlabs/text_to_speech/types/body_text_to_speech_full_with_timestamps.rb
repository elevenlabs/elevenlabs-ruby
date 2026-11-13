# frozen_string_literal: true

module Elevenlabs
  module TextToSpeech
    module Types
      class BodyTextToSpeechFullWithTimestamps < ::Elevenlabs::Internal::Types::Model
        field :text, -> { String }, optional: false, nullable: false
        field :model_id, -> { String }, optional: true, nullable: false
        field :language_code, -> { String }, optional: true, nullable: true
        field :voice_settings, -> { ::Elevenlabs::Types::BodyTextToSpeechFullVoiceSettings }, optional: true, nullable: false
        field :pronunciation_dictionary_locators, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::BodyTextToSpeechFullPronunciationDictionaryLocatorsItem] }, optional: true, nullable: false
        field :seed, -> { Integer }, optional: true, nullable: true
        field :previous_text, -> { String }, optional: true, nullable: true
        field :next_text, -> { String }, optional: true, nullable: true
        field :previous_request_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
        field :next_request_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
        field :use_pvc_as_ivc, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
        field :apply_text_normalization, -> { ::Elevenlabs::TextToSpeech::Types::BodyTextToSpeechFullWithTimestampsApplyTextNormalization }, optional: true, nullable: false
        field :apply_language_text_normalization, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
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
end
