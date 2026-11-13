# frozen_string_literal: true

module Elevenlabs
  module Types
    class Icon < ::Elevenlabs::Internal::Types::Model
      field :src, -> { String }, optional: false, nullable: false
      field :mime_type, -> { String }, optional: true, nullable: true, api_name: 'mimeType'
      field :sizes, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :theme, -> { ::Elevenlabs::Types::IconTheme }, optional: true, nullable: true

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
