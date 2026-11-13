# frozen_string_literal: true

module Elevenlabs
  module Types
    class AudioIsolationHistoryItemResponseModel < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :title, -> { String }, optional: false, nullable: true
      field :created_at_unix, -> { Integer }, optional: false, nullable: false
      field :format, -> { String }, optional: false, nullable: false
      field :duration_seconds, -> { Float }, optional: false, nullable: true
      field :download_url, -> { String }, optional: false, nullable: true
      field :icon_url, -> { String }, optional: false, nullable: true
      field :source_video_url, -> { String }, optional: false, nullable: true
      field :supports_video, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :processing, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :video_processing_failed, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :preview_b64, -> { String }, optional: false, nullable: true

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
