# frozen_string_literal: true

module Elevenlabs
  module Types
    class VeoImageReference < ::Elevenlabs::Internal::Types::Model
      field :image, -> { ::Elevenlabs::Types::ImageReference }, optional: false, nullable: false
      field :role, -> { ::Elevenlabs::Types::VeoImageReferenceRole }, optional: false, nullable: false

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
