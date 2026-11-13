# frozen_string_literal: true

module Elevenlabs
  module Types
    class BodyAddToKnowledgeBaseV1ConvaiKnowledgeBasePost < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: true, nullable: true
      field :url, -> { String }, optional: true, nullable: false
      field :file, -> { String }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(name, 'name', min_length: 1)
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
