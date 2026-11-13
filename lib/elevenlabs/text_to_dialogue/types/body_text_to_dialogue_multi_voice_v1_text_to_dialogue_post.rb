# frozen_string_literal: true

module Elevenlabs
  module TextToDialogue
    module Types
      class BodyTextToDialogueMultiVoiceV1TextToDialoguePost < ::Elevenlabs::Internal::Types::Model
        field :inputs, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DialogueInput] }, optional: false, nullable: false
        field :model_id, -> { String }, optional: true, nullable: false
        field :language_code, -> { String }, optional: true, nullable: true
        field :settings, -> { ::Elevenlabs::Types::ToDialogueSettingsResponseModel }, optional: true, nullable: true
        field :previous_text, -> { String }, optional: true, nullable: true
        field :future_text, -> { String }, optional: true, nullable: true
        field :pronunciation_dictionary_locators, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::BodyTextToSpeechFullPronunciationDictionaryLocatorsItem] }, optional: true, nullable: true
        field :seed, -> { Integer }, optional: true, nullable: true
        field :apply_text_normalization, -> { ::Elevenlabs::TextToDialogue::Types::BodyTextToDialogueMultiVoiceV1TextToDialoguePostApplyTextNormalization }, optional: true, nullable: false
        field :use_pvc_as_ivc, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
        field :previous_request_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
        field :next_request_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
        field :audio_effects, -> { ::Elevenlabs::Types::EffectsSpecInput }, optional: true, nullable: false

        def validate!
          ::Elevenlabs::Validator.validate_string!(previous_text, 'previous_text', max_length: 100)
          ::Elevenlabs::Validator.validate_string!(future_text, 'future_text', max_length: 100)
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
