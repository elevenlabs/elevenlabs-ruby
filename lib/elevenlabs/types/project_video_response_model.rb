# frozen_string_literal: true

module Elevenlabs
  module Types
    class ProjectVideoResponseModel < ::Elevenlabs::Internal::Types::Model
      field :video_id, -> { String }, optional: false, nullable: false
      field :filename, -> { String }, optional: false, nullable: false
      field :signed_url, -> { String }, optional: false, nullable: true
      field :signed_preview_url, -> { String }, optional: false, nullable: true
      field :offset_ms, -> { Integer }, optional: false, nullable: false
      field :duration_ms, -> { Integer }, optional: false, nullable: false
      field :volume_gain_db, -> { Float }, optional: false, nullable: false
      field :muted, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :fade_in_ms, -> { Integer }, optional: true, nullable: false
      field :fade_out_ms, -> { Integer }, optional: true, nullable: false
      field :width, -> { Integer }, optional: false, nullable: false
      field :height, -> { Integer }, optional: false, nullable: false
      field :codec, -> { String }, optional: false, nullable: false
      field :order, -> { String }, optional: false, nullable: false
      field :created_at_ms, -> { Integer }, optional: false, nullable: false
      field :updated_at_ms, -> { Integer }, optional: false, nullable: false
      field :error, -> { String }, optional: true, nullable: true
      field :thumbnail_interval_seconds, -> { Float }, optional: false, nullable: false
      field :thumbnail_size, -> { ::Elevenlabs::Internal::Types::Array[Integer] }, optional: false, nullable: false
      field :thumbnail_sheets, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ProjectVideoThumbnailSheetResponseModel] }, optional: false, nullable: false
      field :start_time_ms, -> { Integer }, optional: false, nullable: false
      field :end_time_ms, -> { Integer }, optional: false, nullable: true
      field :asset_preview_signed_url, -> { String }, optional: true, nullable: true
      field :source_video_id, -> { String }, optional: true, nullable: true
      field :source_asset_id, -> { String }, optional: true, nullable: true
      field :source_platform_asset_id, -> { String }, optional: true, nullable: true
      field :pending_blocks_metadata, -> { ::Elevenlabs::Types::PendingBlocksMetadataModel }, optional: true, nullable: true
      field :pending_external_audios_metadata, -> { ::Elevenlabs::Types::PendingExternalAudiosMetadataModel }, optional: true, nullable: true
      field :speech_imported, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :pending_task, -> { ::Elevenlabs::Types::PendingClipTask }, optional: true, nullable: true
      field :audio_track_ready, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :export_format_ready, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :current_snapshot_id, -> { String }, optional: true, nullable: true
      field :source_context, -> { ::Elevenlabs::Types::GenerationSourceContext }, optional: true, nullable: true
      field :analysis, -> { ::Elevenlabs::Types::VideoAnalysis }, optional: true, nullable: true
      field :transcription, -> { ::Elevenlabs::Types::AssetTranscription }, optional: true, nullable: true
      field :type, -> { ::Elevenlabs::Types::ProjectVideoResponseModelType }, optional: true, nullable: false
      field :canvas_placement, -> { ::Elevenlabs::Types::CanvasPlacement }, optional: true, nullable: false
      field :animation, -> { ::Elevenlabs::Types::ClipAnimation }, optional: true, nullable: false
      field :playback_speed, -> { Float }, optional: true, nullable: false
      field :opacity, -> { Float }, optional: true, nullable: false
      field :track_id, -> { String }, optional: true, nullable: false
      field :preview_job_progress, -> { Float }, optional: true, nullable: false
      field :import_speech_progress, -> { Float }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_array!(thumbnail_size, 'thumbnail_size', min_items: 2, max_items: 2)
        Validator.validate_number!(opacity, 'opacity', min: 0, max: 1)
      end

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
