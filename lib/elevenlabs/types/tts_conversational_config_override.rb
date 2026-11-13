# frozen_string_literal: true

module Elevenlabs
  module Types
    class TtsConversationalConfigOverride < ::Elevenlabs::Internal::Types::Model
      field :model_id, -> { ::Elevenlabs::Types::TtsConversationalModel }, optional: true, nullable: true
      field :voice_id, -> { String }, optional: true, nullable: true
      field :supported_voices, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::SupportedVoice] }, optional: true, nullable: true
      field :stability, -> { Float }, optional: true, nullable: true
      field :speed, -> { Float }, optional: true, nullable: true
      field :similarity_boost, -> { Float }, optional: true, nullable: true
      field :clone_strength, -> { Float }, optional: true, nullable: true
      field :pronunciation_dictionary_locators, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::PydanticPronunciationDictionaryVersionLocator] }, optional: true, nullable: true

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
