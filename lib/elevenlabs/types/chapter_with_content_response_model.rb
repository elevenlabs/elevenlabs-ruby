# frozen_string_literal: true

module Elevenlabs
  module Types
    class ChapterWithContentResponseModel < ::Elevenlabs::Internal::Types::Model
      field :chapter_id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :last_conversion_date_unix, -> { Integer }, optional: true, nullable: true
      field :conversion_progress, -> { Float }, optional: true, nullable: true
      field :can_be_downloaded, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :state, -> { ::Elevenlabs::Types::ChapterWithContentResponseModelState }, optional: false, nullable: false
      field :has_video, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :has_visual_content, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :voice_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :statistics, -> { ::Elevenlabs::Types::ChapterStatisticsResponse }, optional: true, nullable: false
      field :last_conversion_error, -> { String }, optional: true, nullable: true
      field :content, -> { ::Elevenlabs::Types::ChapterContentResponseModel }, optional: false, nullable: false

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
