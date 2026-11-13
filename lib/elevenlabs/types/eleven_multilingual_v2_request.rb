# frozen_string_literal: true

module Elevenlabs
  module Types
    class ElevenMultilingualV2Request < ::Elevenlabs::Internal::Types::Model
      field :webhook, -> { ::Elevenlabs::Types::WebhookTarget }, optional: true, nullable: false
      field :text, -> { String }, optional: false, nullable: false
      field :voice, -> { String }, optional: false, nullable: false
      field :output_format, -> { ::Elevenlabs::Types::ElevenMultilingualV2RequestOutputFormat }, optional: true, nullable: false
      field :pronunciation_dictionary_locators, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ElevenFlashV25RequestPronunciationDictionaryLocatorsItem] }, optional: true, nullable: false
      field :model_id, -> { ::Elevenlabs::Types::ElevenMultilingualV2RequestModelID }, optional: false, nullable: false
      field :voice_settings, -> { ::Elevenlabs::Types::TtsVoiceSettings }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_array!(pronunciation_dictionary_locators, 'pronunciation_dictionary_locators', max_items: 3)
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
