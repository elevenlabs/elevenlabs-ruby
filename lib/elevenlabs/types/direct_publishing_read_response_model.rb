# frozen_string_literal: true

module Elevenlabs
  module Types
    class DirectPublishingReadResponseModel < ::Elevenlabs::Internal::Types::Model
      field :read_id, -> { String }, optional: false, nullable: false
      field :created_at_unix, -> { Integer }, optional: false, nullable: false
      field :updated_at_unix, -> { Integer }, optional: false, nullable: false
      field :word_count, -> { Integer }, optional: false, nullable: false
      field :char_count, -> { Integer }, optional: false, nullable: false
      field :chapters, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ReadMetadataChapterDbModel] }, optional: false, nullable: false
      field :title, -> { String }, optional: true, nullable: true
      field :author, -> { String }, optional: true, nullable: true
      field :description, -> { String }, optional: true, nullable: true
      field :article_image_url, -> { String }, optional: true, nullable: true
      field :language, -> { String }, optional: true, nullable: true
      field :locale, -> { String }, optional: true, nullable: true
      field :display_mode, -> { ::Elevenlabs::Types::DirectPublishingReadResponseModelDisplayMode }, optional: true, nullable: true
      field :genre, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DirectPublishingReadResponseModelGenreItem] }, optional: true, nullable: true
      field :fiction, -> { String }, optional: true, nullable: true
      field :content_type, -> { String }, optional: true, nullable: true
      field :original_file_type, -> { String }, optional: true, nullable: true
      field :target_audience, -> { ::Elevenlabs::Types::DirectPublishingReadResponseModelTargetAudience }, optional: true, nullable: true
      field :mature_content, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :safesearch_adult, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :origin, -> { String }, optional: true, nullable: true
      field :publication_date, -> { String }, optional: true, nullable: true
      field :isbn, -> { String }, optional: true, nullable: true
      field :ean, -> { String }, optional: true, nullable: true
      field :legal_terms, -> { ::Elevenlabs::Types::ReadLegalTerms }, optional: true, nullable: true
      field :content_guidelines_terms, -> { ::Elevenlabs::Types::ReadLegalTerms }, optional: true, nullable: false
      field :last_updated_from_project_unix, -> { Integer }, optional: true, nullable: true
      field :publishing_project_id, -> { String }, optional: true, nullable: true
      field :publishing_state, -> { String }, optional: true, nullable: false
      field :publisher_profile_id, -> { String }, optional: true, nullable: true
      field :quality_score, -> { Integer }, optional: true, nullable: true
      field :publisher, -> { String }, optional: true, nullable: true
      field :copyright, -> { String }, optional: true, nullable: true
      field :subtitle, -> { String }, optional: true, nullable: true
      field :distribution_territories, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :edition, -> { String }, optional: true, nullable: true
      field :contributors, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::Contributor] }, optional: true, nullable: true
      field :payout_type, -> { ::Elevenlabs::Types::DirectPublishingReadResponseModelPayoutType }, optional: true, nullable: true
      field :list_price, -> { Float }, optional: true, nullable: true
      field :currency, -> { ::Elevenlabs::Types::DirectPublishingReadResponseModelCurrency }, optional: true, nullable: true
      field :original_audio_project_export_id, -> { String }, optional: true, nullable: true
      field :original_audio_document_id, -> { String }, optional: true, nullable: true
      field :series_id, -> { String }, optional: true, nullable: true
      field :volume, -> { Integer }, optional: true, nullable: true
      field :published_at_unix, -> { Integer }, optional: true, nullable: true
      field :read_slug, -> { String }, optional: true, nullable: true
      field :preview_audio_object, -> { ::Elevenlabs::Types::PreviewAudioDbModel }, optional: true, nullable: true
      field :sample_config, -> { ::Elevenlabs::Types::SampleConfigDbModel }, optional: true, nullable: true
      field :review, -> { ::Elevenlabs::Types::ReviewResponseModel }, optional: true, nullable: true
      field :voice_id, -> { String }, optional: true, nullable: true
      field :can_use_assistant, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :is_voice_changer_on, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :restricted_to_user_email_domains, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

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
