# frozen_string_literal: true

module Elevenlabs
  module Types
    module Veo31RequestModelID
      extend ::Elevenlabs::Internal::Types::Enum

      VEO_3_1_GENERATE_001 = :'veo-3.1-generate-001'

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
