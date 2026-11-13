# frozen_string_literal: true

module Elevenlabs
  module Types
    module BytedanceSeedance2FastRequestAspectRatio
      extend ::Elevenlabs::Internal::Types::Enum

      AUTO = :auto
      V21_9 = :'21:9'
      V16_9 = :'16:9'
      V4_3 = :'4:3'
      V1_1 = :'1:1'
      V3_4 = :'3:4'
      V9_16 = :'9:16'

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
