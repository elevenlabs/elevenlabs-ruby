# frozen_string_literal: true

module Elevenlabs
  module Types
    class ProjectVideoThumbnailSheetResponseModel < ::Elevenlabs::Internal::Types::Model
      field :start_thumbnail_index, -> { Integer }, optional: false, nullable: false
      field :thumbnail_count, -> { Integer }, optional: false, nullable: false
      field :signed_cloud_url, -> { String }, optional: false, nullable: false

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
