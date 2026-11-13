# frozen_string_literal: true

module Elevenlabs
  module Types
    class TextToDialogueClientMessage < ::Elevenlabs::Internal::Types::Model
      field :inputs, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TextToDialogueClientMessageInputsItem] }, optional: true, nullable: false
      field :flush, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :close_socket, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :keep_alive, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :xi_api_key, -> { String }, optional: true, nullable: false
      field :authorization, -> { String }, optional: true, nullable: false
      field :single_use_token, -> { String }, optional: true, nullable: false
      field :voices, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :voice_settings, -> { ::Elevenlabs::Types::TextToDialogueClientMessageVoiceSettings }, optional: true, nullable: false
      field :pronunciation_dictionary_locators, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TextToDialogueClientMessagePronunciationDictionaryLocatorsItem] }, optional: true, nullable: false

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
