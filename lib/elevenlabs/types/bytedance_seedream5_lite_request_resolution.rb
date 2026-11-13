# frozen_string_literal: true

module Elevenlabs
  module Types
    module BytedanceSeedream5LiteRequestResolution
      extend ::Elevenlabs::Internal::Types::Enum

      V2_K = :'2K'
      V3_K = :'3K'

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
