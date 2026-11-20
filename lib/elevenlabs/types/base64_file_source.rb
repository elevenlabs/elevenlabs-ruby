# frozen_string_literal: true

module Elevenlabs
  module Types
    class Base64FileSource < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::Base64FileSourceType }, optional: false, nullable: false
      field :filename, -> { String }, optional: false, nullable: false
      field :media_type, -> { ::Elevenlabs::Types::FileInputMimeType }, optional: false, nullable: false
      field :data, -> { String }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(filename, 'filename', min_length: 1)
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
