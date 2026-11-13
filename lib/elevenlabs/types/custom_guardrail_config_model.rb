# frozen_string_literal: true

module Elevenlabs
  module Types
    module CustomGuardrailConfigModel
      extend ::Elevenlabs::Internal::Types::Enum

      GEMINI_2_5_FLASH_LITE = :'gemini-2.5-flash-lite'
      GEMINI_2_5_FLASH = :'gemini-2.5-flash'
      GEMINI_3_1_FLASH_LITE = :'gemini-3.1-flash-lite'
      GEMINI_3_5_FLASH = :'gemini-3.5-flash'
      CLAUDE_HAIKU_4_5 = :'claude-haiku-4-5'
      CLAUDE_SONNET_4_6 = :'claude-sonnet-4-6'
      GPT_5_4_NANO = :'gpt-5.4-nano'
      GPT_5_4_MINI = :'gpt-5.4-mini'

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
