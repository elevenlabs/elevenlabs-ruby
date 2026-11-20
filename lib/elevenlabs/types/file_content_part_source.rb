# frozen_string_literal: true

module Elevenlabs
  module Types
    module FileContentPartSource
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::Base64FileSource }, key: 'base64'
      member -> { ::Elevenlabs::Types::FileIDSource }, key: 'file_id'

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
