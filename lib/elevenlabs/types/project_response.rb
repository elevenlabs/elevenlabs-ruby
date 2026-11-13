# frozen_string_literal: true

module Elevenlabs
  module Types
    class ProjectResponse < ::Elevenlabs::Internal::Types::Model
      field :project_id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :create_date_unix, -> { Integer }, optional: false, nullable: false
      field :created_by_user_id, -> { String }, optional: false, nullable: true
      field :default_title_voice_ref_id, -> { String }, optional: false, nullable: false
      field :default_paragraph_voice_ref_id, -> { String }, optional: false, nullable: false
      field :default_model_id, -> { String }, optional: false, nullable: false
      field :last_conversion_date_unix, -> { Integer }, optional: true, nullable: true
      field :can_be_downloaded, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :title, -> { String }, optional: true, nullable: true
      field :author, -> { String }, optional: true, nullable: true
      field :description, -> { String }, optional: true, nullable: true
      field :genres, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :cover_image_url, -> { String }, optional: true, nullable: true
      field :target_audience, -> { ::Elevenlabs::Types::ProjectResponseTargetAudience }, optional: true, nullable: true
      field :language, -> { String }, optional: true, nullable: true
      field :content_type, -> { String }, optional: true, nullable: true
      field :original_publication_date, -> { String }, optional: true, nullable: true
      field :mature_content, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :isbn_number, -> { String }, optional: true, nullable: true
      field :volume_normalization, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :state, -> { ::Elevenlabs::Types::ProjectState }, optional: false, nullable: false
      field :access_level, -> { ::Elevenlabs::Types::ProjectResponseAccessLevel }, optional: false, nullable: false
      field :fiction, -> { ::Elevenlabs::Types::ProjectResponseFiction }, optional: true, nullable: true
      field :quality_check_on, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :quality_check_on_when_bulk_convert, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :creation_meta, -> { ::Elevenlabs::Types::ProjectCreationMetaResponseModel }, optional: true, nullable: true
      field :source_type, -> { ::Elevenlabs::Types::ProjectResponseSourceType }, optional: true, nullable: true
      field :chapters_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :captions_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :caption_style, -> { ::Elevenlabs::Types::CaptionStyleModel }, optional: true, nullable: true
      field :caption_style_template_overrides, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::CaptionStyleModel] }, optional: true, nullable: true
      field :public_share_id, -> { String }, optional: true, nullable: true
      field :aspect_ratio, -> { ::Elevenlabs::Types::ProjectResponseAspectRatio }, optional: true, nullable: true
      field :agent_settings, -> { ::Elevenlabs::Types::StudioAgentSettingsModel }, optional: true, nullable: true
      field :default_title_voice_id, -> { String }, optional: true, nullable: false
      field :default_paragraph_voice_id, -> { String }, optional: true, nullable: false

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
