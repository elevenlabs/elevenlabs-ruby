# frozen_string_literal: true

module Elevenlabs
  module Types
    class Voice < ::Elevenlabs::Internal::Types::Model
      field :voice_id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: true, nullable: false
      field :samples, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::VoiceSample] }, optional: true, nullable: true
      field :category, -> { ::Elevenlabs::Types::Category }, optional: true, nullable: false
      field :fine_tuning, -> { ::Elevenlabs::Types::FineTuningResponse }, optional: true, nullable: true
      field :labels, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :description, -> { String }, optional: true, nullable: true
      field :preview_url, -> { String }, optional: true, nullable: true
      field :available_for_tiers, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :settings, -> { ::Elevenlabs::Types::BodyTextToSpeechFullVoiceSettings }, optional: true, nullable: false
      field :sharing, -> { ::Elevenlabs::Types::VoiceSharingResponse }, optional: true, nullable: true
      field :high_quality_base_model_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :verified_languages, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::VerifiedVoiceLanguageResponseModel] }, optional: true, nullable: true
      field :collection_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :safety_control, -> { ::Elevenlabs::Types::VoiceSafetyControl }, optional: true, nullable: true
      field :voice_verification, -> { ::Elevenlabs::Types::VoiceVerificationResponse }, optional: true, nullable: true
      field :permission_on_resource, -> { String }, optional: true, nullable: true
      field :is_owner, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :is_legacy, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :is_mixed, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :favorited_at_unix, -> { Integer }, optional: true, nullable: true
      field :created_at_unix, -> { Integer }, optional: true, nullable: true
      field :is_bookmarked, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :recording_quality, -> { ::Elevenlabs::Types::VoiceRecordingQuality }, optional: true, nullable: true
      field :labelling_status, -> { ::Elevenlabs::Types::VoiceLabellingStatus }, optional: true, nullable: true
      field :recording_quality_reason, -> { String }, optional: true, nullable: true

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
