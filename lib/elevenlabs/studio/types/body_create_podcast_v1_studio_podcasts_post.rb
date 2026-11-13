# frozen_string_literal: true

module Elevenlabs
  module Studio
    module Types
      class BodyCreatePodcastV1StudioPodcastsPost < ::Elevenlabs::Internal::Types::Model
        field :model_id, -> { String }, optional: false, nullable: false
        field :mode, -> { ::Elevenlabs::Studio::Types::BodyCreatePodcastV1StudioPodcastsPostMode }, optional: false, nullable: false
        field :source, -> { ::Elevenlabs::Studio::Types::BodyCreatePodcastV1StudioPodcastsPostSource }, optional: false, nullable: false
        field :quality_preset, -> { ::Elevenlabs::Types::QualityPresetType }, optional: true, nullable: true
        field :duration_scale, -> { ::Elevenlabs::Studio::Types::BodyCreatePodcastV1StudioPodcastsPostDurationScale }, optional: true, nullable: false
        field :language, -> { String }, optional: true, nullable: true
        field :intro, -> { String }, optional: true, nullable: true
        field :outro, -> { String }, optional: true, nullable: true
        field :instructions_prompt, -> { String }, optional: true, nullable: true
        field :highlights, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
        field :callback_url, -> { String }, optional: true, nullable: true
        field :apply_text_normalization, -> { ::Elevenlabs::Studio::Types::BodyCreatePodcastV1StudioPodcastsPostApplyTextNormalization }, optional: true, nullable: true

        def validate!
          ::Elevenlabs::Validator.validate_string!(language, 'language', min_length: 2, max_length: 2)
          ::Elevenlabs::Validator.validate_string!(intro, 'intro', max_length: 1500)
          ::Elevenlabs::Validator.validate_string!(outro, 'outro', max_length: 1500)
          ::Elevenlabs::Validator.validate_string!(instructions_prompt, 'instructions_prompt', max_length: 3000)
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
