# frozen_string_literal: true

module Elevenlabs
  module AudioNative
    module Types
      class BodyCreatesAudioNativeEnabledProjectV1AudioNativePost < ::Elevenlabs::Internal::Types::Model
        field :name, -> { String }, optional: false, nullable: false
        field :image, -> { String }, optional: true, nullable: true
        field :author, -> { String }, optional: true, nullable: true
        field :title, -> { String }, optional: true, nullable: true
        field :small, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :text_color, -> { String }, optional: true, nullable: true
        field :background_color, -> { String }, optional: true, nullable: true
        field :sessionization, -> { Integer }, optional: true, nullable: false
        field :voice_id, -> { String }, optional: true, nullable: true
        field :model_id, -> { String }, optional: true, nullable: true
        field :file, -> { String }, optional: true, nullable: false
        field :auto_convert, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :apply_text_normalization, -> { ::Elevenlabs::AudioNative::Types::BodyCreatesAudioNativeEnabledProjectV1AudioNativePostApplyTextNormalization }, optional: true, nullable: true
        field :pronunciation_dictionary_locators, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false

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
