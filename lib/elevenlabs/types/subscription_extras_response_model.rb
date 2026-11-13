# frozen_string_literal: true

module Elevenlabs
  module Types
    class SubscriptionExtrasResponseModel < ::Elevenlabs::Internal::Types::Model
      field :concurrency, -> { Integer }, optional: false, nullable: false
      field :convai_concurrency, -> { Integer }, optional: false, nullable: false
      field :enterprise_music_concurrency, -> { Integer }, optional: true, nullable: true
      field :music_finetunes_total_limit, -> { Integer }, optional: true, nullable: true
      field :music_finetunes_monthly_limit, -> { Integer }, optional: true, nullable: true
      field :music_finetunes_concurrency_limit, -> { Integer }, optional: true, nullable: true
      field :convai_chars_per_minute, -> { Integer }, optional: true, nullable: true
      field :convai_asr_chars_per_minute, -> { Integer }, optional: true, nullable: true
      field :force_logging_disabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :can_request_manual_pro_voice_verification, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :can_bypass_voice_captcha, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :moderation, -> { ::Elevenlabs::Types::ModerationStatusResponseModel }, optional: false, nullable: false
      field :unused_characters_rolled_over_from_previous_period, -> { Integer }, optional: true, nullable: true
      field :overused_characters_rolled_over_from_previous_period, -> { Integer }, optional: true, nullable: true
      field :usage, -> { ::Elevenlabs::Types::SubscriptionUsageResponseModel }, optional: true, nullable: true

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
