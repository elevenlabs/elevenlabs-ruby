# frozen_string_literal: true

module Elevenlabs
  module Types
    module GptImage15RequestModelID
      extend ::Elevenlabs::Internal::Types::Enum

      GPT_IMAGE_1_5 = :'gpt-image-1.5'

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
