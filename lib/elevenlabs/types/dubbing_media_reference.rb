# frozen_string_literal: true

module Elevenlabs
  module Types
    class DubbingMediaReference < ::Elevenlabs::Internal::Types::Model
      field :src, -> { String }, optional: false, nullable: false
      field :content_type, -> { String }, optional: false, nullable: false
      field :bucket_name, -> { String }, optional: false, nullable: false
      field :random_path_slug, -> { String }, optional: false, nullable: false
      field :duration_secs, -> { Float }, optional: false, nullable: false
      field :is_audio, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :url, -> { String }, optional: false, nullable: false

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
