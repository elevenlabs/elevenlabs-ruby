# frozen_string_literal: true

module Elevenlabs
  module Types
    class TranscriptionOrderItemRequest < ::Elevenlabs::Internal::Types::Model
      field :kind, -> { ::Elevenlabs::Types::TranscriptionOrderItemRequestKind }, optional: true, nullable: false
      field :media_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :source_language, -> { String }, optional: false, nullable: false
      field :verbatim, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :instructions, -> { String }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_array!(media_ids, 'media_ids', max_items: 50)
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
