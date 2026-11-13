# frozen_string_literal: true

module Elevenlabs
  module TextToVoice
    module Types
      class BodyCreateANewVoiceFromVoicePreviewV1TextToVoicePost < ::Elevenlabs::Internal::Types::Model
        field :voice_name, -> { String }, optional: false, nullable: false
        field :voice_description, -> { String }, optional: false, nullable: false
        field :generated_voice_id, -> { String }, optional: false, nullable: false
        field :labels, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: true
        field :played_not_selected_voice_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

        def validate!
          ::Elevenlabs::Validator.validate_string!(voice_description, 'voice_description', min_length: 20, max_length: 1000)
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
