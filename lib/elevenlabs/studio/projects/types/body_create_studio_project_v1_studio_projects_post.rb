# frozen_string_literal: true

module Elevenlabs
  module Studio
    module Projects
      module Types
        class BodyCreateStudioProjectV1StudioProjectsPost < ::Elevenlabs::Internal::Types::Model
          field :name, -> { String }, optional: false, nullable: false
          field :default_title_voice_id, -> { String }, optional: true, nullable: true
          field :default_paragraph_voice_id, -> { String }, optional: true, nullable: true
          field :default_model_id, -> { String }, optional: true, nullable: true
          field :from_url, -> { String }, optional: true, nullable: true
          field :from_document, -> { String }, optional: true, nullable: true
          field :from_content_json, -> { String }, optional: true, nullable: false
          field :quality_preset, -> { ::Elevenlabs::Types::QualityPresetType }, optional: true, nullable: false
          field :title, -> { String }, optional: true, nullable: true
          field :author, -> { String }, optional: true, nullable: true
          field :description, -> { String }, optional: true, nullable: true
          field :genres, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
          field :target_audience, -> { ::Elevenlabs::Studio::Projects::Types::BodyCreateStudioProjectV1StudioProjectsPostTargetAudience }, optional: true, nullable: true
          field :language, -> { String }, optional: true, nullable: true
          field :content_type, -> { String }, optional: true, nullable: true
          field :original_publication_date, -> { String }, optional: true, nullable: true
          field :mature_content, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
          field :isbn_number, -> { String }, optional: true, nullable: true
          field :acx_volume_normalization, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
          field :volume_normalization, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
          field :pronunciation_dictionary_locators, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
          field :callback_url, -> { String }, optional: true, nullable: true
          field :fiction, -> { ::Elevenlabs::Studio::Projects::Types::BodyCreateStudioProjectV1StudioProjectsPostFiction }, optional: true, nullable: true
          field :apply_text_normalization, -> { ::Elevenlabs::Studio::Projects::Types::BodyCreateStudioProjectV1StudioProjectsPostApplyTextNormalization }, optional: true, nullable: true
          field :auto_convert, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
          field :auto_assign_voices, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
          field :source_type, -> { ::Elevenlabs::Studio::Projects::Types::BodyCreateStudioProjectV1StudioProjectsPostSourceType }, optional: true, nullable: true
          field :voice_settings, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
          field :create_publishing_read, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

          def validate!
            ::Elevenlabs::Validator.validate_string!(language, 'language', min_length: 2, max_length: 2)
            ::Elevenlabs::Validator.validate_string!(original_publication_date, 'original_publication_date', pattern: /^\d{4}-\d{2}-\d{2}$|^\d{4}$/)
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
end
