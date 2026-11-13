# frozen_string_literal: true

module Elevenlabs
  module Types
    class LanguagePresetInput < ::Elevenlabs::Internal::Types::Model
      field :overrides, -> { ::Elevenlabs::Types::ConversationConfigClientOverrideInput }, optional: false, nullable: false
      field :first_message_translation, -> { ::Elevenlabs::Types::LanguagePresetTranslation }, optional: true, nullable: true
      field :soft_timeout_translation, -> { ::Elevenlabs::Types::LanguagePresetTranslation }, optional: true, nullable: false
      field :noisy_environment_message_translation, -> { ::Elevenlabs::Types::LanguagePresetTranslation }, optional: true, nullable: false

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
