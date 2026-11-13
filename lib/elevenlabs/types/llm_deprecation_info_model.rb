# frozen_string_literal: true

module Elevenlabs
  module Types
    class LlmDeprecationInfoModel < ::Elevenlabs::Internal::Types::Model
      field :llm, -> { ::Elevenlabs::Types::Llm }, optional: false, nullable: false
      field :is_deprecated, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :is_in_warning_period, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :is_in_fallback_period, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :fallback_percentage, -> { Integer }, optional: true, nullable: false
      field :provider_deprecation_date, -> { String }, optional: true, nullable: true
      field :replacement_model, -> { ::Elevenlabs::Types::Llm }, optional: true, nullable: false
      field :deprecation_config, -> { ::Elevenlabs::Types::LlmDeprecationConfigModel }, optional: true, nullable: true

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
