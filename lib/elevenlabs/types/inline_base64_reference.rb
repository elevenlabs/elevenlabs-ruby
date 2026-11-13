# frozen_string_literal: true

module Elevenlabs
  module Types
    class InlineBase64Reference < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::InlineBase64ReferenceType }, optional: false, nullable: false
      field :content_base64, -> { String }, optional: false, nullable: false
      field :mime_type, -> { ::Elevenlabs::Types::InlineBase64ReferenceMimeType }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(content_base64, 'content_base64', max_length: 34_952_536)
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
