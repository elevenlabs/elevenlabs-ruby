# frozen_string_literal: true

module Elevenlabs
  module Types
    class DubOrderItemRequest < ::Elevenlabs::Internal::Types::Model
      field :kind, -> { ::Elevenlabs::Types::DubOrderItemRequestKind }, optional: true, nullable: false
      field :media_id, -> { String }, optional: false, nullable: false
      field :source_language, -> { String }, optional: false, nullable: false
      field :destination_languages, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :include_captions, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :include_source_captions, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :instructions, -> { String }, optional: true, nullable: true
      field :captions_sdh, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_string!(media_id, 'media_id', pattern: /^prodmedia_[a-z0-9]{26}$/)
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
