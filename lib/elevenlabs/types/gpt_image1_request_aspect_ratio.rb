# frozen_string_literal: true

module Elevenlabs
  module Types
    module GptImage1RequestAspectRatio
      extend ::Elevenlabs::Internal::Types::Enum

      V1_1 = :'1:1'
      V3_2 = :'3:2'
      V2_3 = :'2:3'

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
