# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationChargingCommonModel < ::Elevenlabs::Internal::Types::Model
      field :dev_discount, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :is_burst, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :tier, -> { String }, optional: true, nullable: true
      field :llm_usage, -> { ::Elevenlabs::Types::LlmCategoryUsage }, optional: true, nullable: false
      field :llm_price, -> { Float }, optional: true, nullable: true
      field :llm_charge, -> { Integer }, optional: true, nullable: true
      field :call_charge, -> { Integer }, optional: true, nullable: true
      field :platform_charge, -> { Integer }, optional: true, nullable: true
      field :platform_usage, -> { ::Elevenlabs::Types::PlatformUsage }, optional: true, nullable: false
      field :platform_price, -> { Float }, optional: true, nullable: true
      field :free_minutes_consumed, -> { Float }, optional: true, nullable: false
      field :free_llm_dollars_consumed, -> { Float }, optional: true, nullable: false
      field :tts_usage, -> { ::Elevenlabs::Types::ConversationTtsUsageModel }, optional: true, nullable: true
      field :asr_usage, -> { ::Elevenlabs::Types::ConversationAsrUsageModel }, optional: true, nullable: true
      field :analysis, -> { ::Elevenlabs::Types::AnalysisCharging }, optional: true, nullable: true
      field :voice_surcharge_charge, -> { Integer }, optional: true, nullable: true

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
