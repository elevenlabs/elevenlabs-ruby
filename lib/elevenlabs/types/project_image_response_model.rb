# frozen_string_literal: true

module Elevenlabs
  module Types
    class ProjectImageResponseModel < ::Elevenlabs::Internal::Types::Model
      field :image_id, -> { String }, optional: false, nullable: false
      field :filename, -> { String }, optional: false, nullable: false
      field :signed_url, -> { String }, optional: true, nullable: true
      field :thumbnail_signed_url, -> { String }, optional: true, nullable: true
      field :type, -> { ::Elevenlabs::Types::ProjectImageResponseModelType }, optional: true, nullable: false
      field :source, -> { ::Elevenlabs::Types::ProjectImageResponseModelSource }, optional: true, nullable: false
      field :file_size_bytes, -> { Integer }, optional: false, nullable: false
      field :width, -> { Integer }, optional: false, nullable: false
      field :height, -> { Integer }, optional: false, nullable: false
      field :track_id, -> { String }, optional: true, nullable: false
      field :offset_ms, -> { Integer }, optional: false, nullable: false
      field :duration_ms, -> { Integer }, optional: false, nullable: false
      field :order, -> { String }, optional: false, nullable: false
      field :canvas_placement, -> { ::Elevenlabs::Types::CanvasPlacement }, optional: false, nullable: false
      field :animation, -> { ::Elevenlabs::Types::ClipAnimation }, optional: true, nullable: false
      field :opacity, -> { Float }, optional: true, nullable: false
      field :created_at_ms, -> { Integer }, optional: false, nullable: false
      field :updated_at_ms, -> { Integer }, optional: false, nullable: false
      field :current_snapshot_id, -> { String }, optional: true, nullable: true
      field :source_asset_id, -> { String }, optional: true, nullable: true
      field :source_platform_asset_id, -> { String }, optional: true, nullable: true
      field :error, -> { String }, optional: true, nullable: true
      field :pending_task, -> { ::Elevenlabs::Types::PendingClipTask }, optional: true, nullable: false
      field :analysis, -> { ::Elevenlabs::Types::ImageAnalysis }, optional: true, nullable: true

      def validate!
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
