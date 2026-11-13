# frozen_string_literal: true

module Elevenlabs
  module Types
    class SoftTimeoutConfigWorkflowOverride < ::Elevenlabs::Internal::Types::Model
      field :timeout_seconds, -> { Float }, optional: true, nullable: true
      field :message, -> { String }, optional: true, nullable: true
      field :additional_soft_timeout_messages, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :use_llm_generated_message, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :randomize_fillers, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :max_soft_timeouts_per_generation, -> { Integer }, optional: true, nullable: true
      field :llm_generated_message_prompt_override, -> { String }, optional: true, nullable: true
      field :disable_until_first_user_message, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

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
