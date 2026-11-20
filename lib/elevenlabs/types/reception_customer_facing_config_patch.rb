# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionCustomerFacingConfigPatch < ::Elevenlabs::Internal::Types::Model
      field :additional_instructions, -> { String }, optional: true, nullable: false
      field :tone_traits, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :details_to_collect, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :llm, -> { ::Elevenlabs::Types::Llm }, optional: true, nullable: false
      field :reasoning_effort, -> { ::Elevenlabs::Types::LlmReasoningEffort }, optional: true, nullable: false
      field :disable_rag, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :background_voice_detection, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :turn_eagerness, -> { ::Elevenlabs::Types::ReceptionTurnEagerness }, optional: true, nullable: false
      field :voice_id, -> { String }, optional: true, nullable: false
      field :language, -> { String }, optional: true, nullable: false
      field :additional_languages, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :first_message, -> { String }, optional: true, nullable: false
      field :first_message_mode, -> { ::Elevenlabs::Types::FirstMessageMode }, optional: true, nullable: false
      field :enable_end_call_tool, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :enable_skip_turn_tool, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :enable_play_keypad_touch_tone_tool, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :hide_caller_number_on_transfers, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :record_after_transfers, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :enable_secure_mode, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :enable_spam_protection, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
