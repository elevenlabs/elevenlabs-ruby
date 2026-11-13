# frozen_string_literal: true

module Elevenlabs
  module Types
    class InitializeConnectionMulti < ::Elevenlabs::Internal::Types::Model
      field :text, -> { ::Elevenlabs::Types::InitializeConnectionMultiText }, optional: false, nullable: false
      field :voice_settings, -> { ::Elevenlabs::Types::InitializeConnectionMultiVoiceSettings }, optional: true, nullable: false
      field :generation_config, -> { ::Elevenlabs::Types::InitializeConnectionMultiGenerationConfig }, optional: true, nullable: false
      field :pronunciation_dictionary_locators, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::InitializeConnectionMultiPronunciationDictionaryLocatorsItem] }, optional: true, nullable: false
      field :xi_api_key, -> { String }, optional: true, nullable: false
      field :authorization, -> { String }, optional: true, nullable: false
      field :context_id, -> { String }, optional: true, nullable: false

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
