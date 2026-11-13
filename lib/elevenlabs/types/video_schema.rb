# frozen_string_literal: true

module Elevenlabs
  module Types
    class VideoSchema < ::Elevenlabs::Internal::Types::Model
      field :title, -> { String }, optional: true, nullable: true
      field :description, -> { String }, optional: true, nullable: true
      field :type, -> { ::Elevenlabs::Types::VideoSchemaType }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(description, 'description', max_length: 500)
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
