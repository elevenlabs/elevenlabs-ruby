# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationInitiationClientDataConversationConfigOverrideTts < ::Elevenlabs::Internal::Types::Model
      field :model_id, -> { ::Elevenlabs::Types::ConversationInitiationClientDataConversationConfigOverrideTtsModelID }, optional: true, nullable: false
      field :voice_id, -> { String }, optional: true, nullable: false
      field :supported_voices, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationInitiationClientDataConversationConfigOverrideTtsSupportedVoicesItem] }, optional: true, nullable: false
      field :stability, -> { Float }, optional: true, nullable: false
      field :speed, -> { Float }, optional: true, nullable: false
      field :similarity_boost, -> { Float }, optional: true, nullable: false
      field :clone_strength, -> { Float }, optional: true, nullable: false
      field :pronunciation_dictionary_locators, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationInitiationClientDataConversationConfigOverrideTtsPronunciationDictionaryLocatorsItem] }, optional: true, nullable: false

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
