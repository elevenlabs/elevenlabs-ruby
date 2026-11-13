# frozen_string_literal: true

module Elevenlabs
  module Types
    class SessionStartedConfig < ::Elevenlabs::Internal::Types::Model
      field :sample_rate, -> { Integer }, optional: false, nullable: false
      field :audio_format, -> { ::Elevenlabs::Types::SessionStartedConfigAudioFormat }, optional: false, nullable: false
      field :language_code, -> { String }, optional: false, nullable: true
      field :secondary_languages, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :timestamps_granularity, -> { ::Elevenlabs::Types::SessionStartedConfigTimestampsGranularity }, optional: true, nullable: false
      field :vad_commit_strategy, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :vad_silence_threshold_secs, -> { Float }, optional: true, nullable: false
      field :vad_threshold, -> { Float }, optional: true, nullable: false
      field :min_speech_duration_ms, -> { Integer }, optional: true, nullable: false
      field :min_silence_duration_ms, -> { Integer }, optional: true, nullable: false
      field :max_tokens_to_recompute, -> { Integer }, optional: true, nullable: false
      field :model_id, -> { ::Elevenlabs::Types::SessionStartedConfigModelID }, optional: true, nullable: false
      field :disable_logging, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :include_timestamps, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :include_language_detection, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :filter_background_audio, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :keyterms, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :no_verbatim, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :entity_detection, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :entity_redaction, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :entity_redaction_mode, -> { String }, optional: true, nullable: false
      field :keepalive_interval_ms, -> { Integer }, optional: true, nullable: true

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
