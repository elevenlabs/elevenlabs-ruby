# frozen_string_literal: true

module Elevenlabs
  module Types
    module BytedanceSeedance2RequestModelID
      extend ::Elevenlabs::Internal::Types::Enum

      BYTEDANCE_SEEDANCE_V2 = :'bytedance-seedance-v2'

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
