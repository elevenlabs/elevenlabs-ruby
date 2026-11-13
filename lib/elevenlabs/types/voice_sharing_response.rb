# frozen_string_literal: true

module Elevenlabs
  module Types
    class VoiceSharingResponse < ::Elevenlabs::Internal::Types::Model
      field :status, -> { ::Elevenlabs::Types::VoiceSharingState }, optional: true, nullable: false
      field :history_item_sample_id, -> { String }, optional: true, nullable: true
      field :date_unix, -> { Integer }, optional: true, nullable: false
      field :whitelisted_emails, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :public_owner_id, -> { String }, optional: true, nullable: false
      field :original_voice_id, -> { String }, optional: true, nullable: false
      field :financial_rewards_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :free_users_allowed, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :live_moderation_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :rate, -> { Float }, optional: true, nullable: true
      field :fiat_rate, -> { Float }, optional: true, nullable: true
      field :notice_period, -> { Integer }, optional: true, nullable: false
      field :disable_at_unix, -> { Integer }, optional: true, nullable: true
      field :voice_mixing_allowed, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :featured, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :category, -> { ::Elevenlabs::Types::VoiceSharingResponseCategory }, optional: true, nullable: false
      field :reader_app_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :image_url, -> { String }, optional: true, nullable: true
      field :ban_reason, -> { String }, optional: true, nullable: true
      field :liked_by_count, -> { Integer }, optional: true, nullable: false
      field :cloned_by_count, -> { Integer }, optional: true, nullable: false
      field :name, -> { String }, optional: true, nullable: false
      field :description, -> { String }, optional: true, nullable: true
      field :labels, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :review_status, -> { ::Elevenlabs::Types::ReviewStatus }, optional: true, nullable: false
      field :review_message, -> { String }, optional: true, nullable: true
      field :enabled_in_library, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :instagram_username, -> { String }, optional: true, nullable: true
      field :twitter_username, -> { String }, optional: true, nullable: true
      field :youtube_username, -> { String }, optional: true, nullable: true
      field :tiktok_username, -> { String }, optional: true, nullable: true
      field :moderation_check, -> { ::Elevenlabs::Types::VoiceSharingModerationCheckResponseModel }, optional: true, nullable: true
      field :reader_restricted_on, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ReaderResourceResponseModel] }, optional: true, nullable: true

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
