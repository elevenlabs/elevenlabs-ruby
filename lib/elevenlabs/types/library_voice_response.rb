# frozen_string_literal: true

module Elevenlabs
  module Types
    class LibraryVoiceResponse < ::Elevenlabs::Internal::Types::Model
      field :public_owner_id, -> { String }, optional: false, nullable: false
      field :voice_id, -> { String }, optional: false, nullable: false
      field :date_unix, -> { Integer }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :accent, -> { String }, optional: false, nullable: false
      field :gender, -> { String }, optional: false, nullable: false
      field :age, -> { String }, optional: false, nullable: false
      field :descriptive, -> { String }, optional: false, nullable: false
      field :use_case, -> { String }, optional: false, nullable: false
      field :category, -> { ::Elevenlabs::Types::LibraryVoiceResponseCategory }, optional: false, nullable: false
      field :language, -> { String }, optional: true, nullable: true
      field :locale, -> { String }, optional: true, nullable: true
      field :description, -> { String }, optional: true, nullable: true
      field :preview_url, -> { String }, optional: true, nullable: true
      field :usage_character_count1y, -> { Integer }, optional: false, nullable: false, api_name: 'usage_character_count_1y'
      field :usage_character_count7d, -> { Integer }, optional: false, nullable: false, api_name: 'usage_character_count_7d'
      field :play_api_usage_character_count1y, -> { Integer }, optional: false, nullable: false, api_name: 'play_api_usage_character_count_1y'
      field :cloned_by_count, -> { Integer }, optional: false, nullable: false
      field :rate, -> { Float }, optional: true, nullable: true
      field :fiat_rate, -> { Float }, optional: true, nullable: true
      field :free_users_allowed, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :live_moderation_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :featured, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :verified_languages, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::VerifiedVoiceLanguageResponseModel] }, optional: true, nullable: true
      field :notice_period, -> { Integer }, optional: true, nullable: true
      field :instagram_username, -> { String }, optional: true, nullable: true
      field :twitter_username, -> { String }, optional: true, nullable: true
      field :youtube_username, -> { String }, optional: true, nullable: true
      field :tiktok_username, -> { String }, optional: true, nullable: true
      field :image_url, -> { String }, optional: true, nullable: true
      field :is_added_by_user, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :is_bookmarked, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

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
