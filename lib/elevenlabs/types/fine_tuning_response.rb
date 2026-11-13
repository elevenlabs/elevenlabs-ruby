# frozen_string_literal: true

module Elevenlabs
  module Types
    class FineTuningResponse < ::Elevenlabs::Internal::Types::Model
      field :is_allowed_to_fine_tune, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :state, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::TextToVoice::Types::FineTuningResponseStateValue] }, optional: true, nullable: false
      field :verification_failures, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :verification_attempts_count, -> { Integer }, optional: true, nullable: false
      field :manual_verification_requested, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :language, -> { String }, optional: true, nullable: true
      field :progress, -> { ::Elevenlabs::Internal::Types::Hash[String, Float] }, optional: true, nullable: true
      field :message, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: true, nullable: true
      field :dataset_duration_seconds, -> { Float }, optional: true, nullable: true
      field :verification_attempts, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::VerificationAttemptResponse] }, optional: true, nullable: true
      field :slice_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :manual_verification, -> { ::Elevenlabs::Types::ManualVerificationResponse }, optional: true, nullable: true
      field :max_verification_attempts, -> { Integer }, optional: true, nullable: true
      field :next_max_verification_attempts_reset_unix_ms, -> { Integer }, optional: true, nullable: true
      field :finetuning_state, -> { Object }, optional: true, nullable: false

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
