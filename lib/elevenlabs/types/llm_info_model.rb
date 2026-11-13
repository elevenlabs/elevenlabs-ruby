# frozen_string_literal: true

module Elevenlabs
  module Types
    class LlmInfoModel < ::Elevenlabs::Internal::Types::Model
      field :llm, -> { ::Elevenlabs::Types::Llm }, optional: false, nullable: false
      field :is_checkpoint, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :max_tokens_limit, -> { Integer }, optional: false, nullable: false
      field :max_context_limit, -> { Integer }, optional: false, nullable: false
      field :supports_image_input, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :supports_document_input, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :supports_parallel_tool_calls, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :available_reasoning_efforts, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::LlmReasoningEffort] }, optional: true, nullable: true
      field :available_service_tiers, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::LlmServiceTier] }, optional: false, nullable: false
      field :deprecation_info, -> { ::Elevenlabs::Types::LlmDeprecationInfoModel }, optional: true, nullable: true
      field :regional_processing_surcharge, -> { ::Elevenlabs::Types::RegionalProcessingSurchargeInfo }, optional: true, nullable: true

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
