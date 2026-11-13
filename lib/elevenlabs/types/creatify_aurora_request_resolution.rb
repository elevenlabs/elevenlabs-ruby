# frozen_string_literal: true

module Elevenlabs
  module Types
    module CreatifyAuroraRequestResolution
      extend ::Elevenlabs::Internal::Types::Enum

      V480P = :'480p'
      V720P = :'720p'

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
