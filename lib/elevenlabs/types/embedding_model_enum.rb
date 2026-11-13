# frozen_string_literal: true

module Elevenlabs
  module Types
    module EmbeddingModelEnum
      extend ::Elevenlabs::Internal::Types::Enum

      E5_MISTRAL_7B_INSTRUCT = :e5_mistral_7b_instruct
      MULTILINGUAL_E5_LARGE_INSTRUCT = :multilingual_e5_large_instruct

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
