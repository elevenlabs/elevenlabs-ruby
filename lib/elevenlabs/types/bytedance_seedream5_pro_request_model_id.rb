# frozen_string_literal: true

module Elevenlabs
  module Types
    module BytedanceSeedream5ProRequestModelID
      extend ::Elevenlabs::Internal::Types::Enum

      BYTEDANCE_SEEDREAM_5_PRO = :'bytedance-seedream-5-pro'

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
