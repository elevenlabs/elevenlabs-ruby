# frozen_string_literal: true

module Elevenlabs
  module Types
    class ModerationStatusResponseModel < ::Elevenlabs::Internal::Types::Model
      field :is_in_probation, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :enterprise_check_nogo_voice, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :enterprise_check_block_nogo_voice, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :never_live_moderate, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :nogo_voice_similar_voice_upload_count, -> { Integer }, optional: false, nullable: false
      field :enterprise_background_moderation_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :is_ivc_captcha_required, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :safety_status, -> { ::Elevenlabs::Types::ModerationStatusResponseModelSafetyStatus }, optional: true, nullable: true
      field :warning_status, -> { ::Elevenlabs::Types::ModerationStatusResponseModelWarningStatus }, optional: true, nullable: true
      field :on_watchlist, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false

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
