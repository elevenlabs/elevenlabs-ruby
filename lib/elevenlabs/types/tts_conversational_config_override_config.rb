# frozen_string_literal: true

module Elevenlabs
  module Types
    class TtsConversationalConfigOverrideConfig < ::Elevenlabs::Internal::Types::Model
      field :model_id, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :voice_id, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :supported_voices, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :stability, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :speed, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :similarity_boost, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :clone_strength, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :pronunciation_dictionary_locators, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
