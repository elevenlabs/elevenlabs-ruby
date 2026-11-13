# frozen_string_literal: true

module Elevenlabs
  module Types
    module Veo31RequestResolution
      extend ::Elevenlabs::Internal::Types::Enum

      V720P = :'720p'
      V1080P = :'1080p'
      V4_K = :'4K'

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
