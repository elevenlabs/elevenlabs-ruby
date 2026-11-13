# frozen_string_literal: true

module Elevenlabs
  module Types
    class SoftTimeoutConfig < ::Elevenlabs::Internal::Types::Model
      field :timeout_seconds, -> { Float }, optional: true, nullable: false
      field :message, -> { String }, optional: true, nullable: false
      field :additional_soft_timeout_messages, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :use_llm_generated_message, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :randomize_fillers, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :max_soft_timeouts_per_generation, -> { Integer }, optional: true, nullable: false
      field :llm_generated_message_prompt_override, -> { String }, optional: true, nullable: true
      field :disable_until_first_user_message, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(message, 'message', min_length: 1, max_length: 200)
        ::Elevenlabs::Validator.validate_array!(additional_soft_timeout_messages, 'additional_soft_timeout_messages', max_items: 7)
        ::Elevenlabs::Validator.validate_integer!(max_soft_timeouts_per_generation, 'max_soft_timeouts_per_generation', min: 1, max: 8)
        ::Elevenlabs::Validator.validate_string!(llm_generated_message_prompt_override, 'llm_generated_message_prompt_override', min_length: 1, max_length: 1000)
      end

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
