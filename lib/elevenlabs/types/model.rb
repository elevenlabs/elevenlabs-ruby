# frozen_string_literal: true

module Elevenlabs
  module Types
    class Model < ::Elevenlabs::Internal::Types::Model
      field :model_id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: true, nullable: false
      field :can_be_finetuned, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :can_do_text_to_speech, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :can_do_voice_conversion, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :can_use_style, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :can_use_speaker_boost, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :serves_pro_voices, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :token_cost_factor, -> { Float }, optional: true, nullable: false
      field :description, -> { String }, optional: true, nullable: false
      field :requires_alpha_access, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :max_characters_request_free_user, -> { Integer }, optional: true, nullable: false
      field :max_characters_request_subscribed_user, -> { Integer }, optional: true, nullable: false
      field :maximum_text_length_per_request, -> { Integer }, optional: true, nullable: false
      field :languages, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::LanguageResponse] }, optional: true, nullable: false
      field :model_rates, -> { ::Elevenlabs::Types::ModelRatesResponseModel }, optional: true, nullable: false
      field :concurrency_group, -> { String }, optional: true, nullable: false

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
