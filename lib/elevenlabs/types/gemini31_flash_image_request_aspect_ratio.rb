# frozen_string_literal: true

module Elevenlabs
  module Types
    module Gemini31FlashImageRequestAspectRatio
      extend ::Elevenlabs::Internal::Types::Enum

      AUTO = :auto
      V1_1 = :'1:1'
      V2_3 = :'2:3'
      V3_2 = :'3:2'
      V3_4 = :'3:4'
      V4_3 = :'4:3'
      V4_5 = :'4:5'
      V5_4 = :'5:4'
      V9_16 = :'9:16'
      V16_9 = :'16:9'
      V21_9 = :'21:9'
      V1_4 = :'1:4'
      V4_1 = :'4:1'
      V1_8 = :'1:8'
      V8_1 = :'8:1'

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
