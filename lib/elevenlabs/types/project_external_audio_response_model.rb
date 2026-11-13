# frozen_string_literal: true

module Elevenlabs
  module Types
    class ProjectExternalAudioResponseModel < ::Elevenlabs::Internal::Types::Model
      field :external_audio_id, -> { String }, optional: false, nullable: false
      field :filename, -> { String }, optional: false, nullable: false
      field :signed_url, -> { String }, optional: false, nullable: true
      field :offset_ms, -> { Integer }, optional: false, nullable: false
      field :duration_ms, -> { Integer }, optional: false, nullable: false
      field :start_time_ms, -> { Integer }, optional: false, nullable: false
      field :end_time_ms, -> { Integer }, optional: false, nullable: true
      field :order, -> { String }, optional: false, nullable: false
      field :track_id, -> { String }, optional: false, nullable: false
      field :created_at_ms, -> { Integer }, optional: false, nullable: false
      field :updated_at_ms, -> { Integer }, optional: false, nullable: false
      field :volume_gain_db, -> { Float }, optional: true, nullable: false
      field :muted, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :fade_in_ms, -> { Integer }, optional: true, nullable: false
      field :fade_out_ms, -> { Integer }, optional: true, nullable: false
      field :source_external_audio_id, -> { String }, optional: true, nullable: true
      field :source_asset_id, -> { String }, optional: true, nullable: true
      field :source_platform_asset_id, -> { String }, optional: true, nullable: true
      field :pending_blocks_metadata, -> { ::Elevenlabs::Types::PendingBlocksMetadataModel }, optional: true, nullable: false
      field :pending_external_audios_metadata, -> { ::Elevenlabs::Types::PendingExternalAudiosMetadataModel }, optional: true, nullable: false
      field :speech_imported, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :pending_task, -> { ::Elevenlabs::Types::PendingClipTask }, optional: true, nullable: false
      field :error, -> { String }, optional: true, nullable: true
      field :current_snapshot_id, -> { String }, optional: true, nullable: true
      field :source_context, -> { ::Elevenlabs::Types::ProjectExternalAudioResponseModelSourceContext }, optional: true, nullable: true
      field :analysis, -> { ::Elevenlabs::Types::AudioAnalysis }, optional: true, nullable: true
      field :transcription, -> { ::Elevenlabs::Types::AssetTranscription }, optional: true, nullable: false
      field :type, -> { ::Elevenlabs::Types::ProjectExternalAudioResponseModelType }, optional: true, nullable: false
      field :import_speech_progress, -> { Float }, optional: true, nullable: true

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
