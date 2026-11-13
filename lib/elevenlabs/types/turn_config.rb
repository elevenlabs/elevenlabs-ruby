# frozen_string_literal: true

module Elevenlabs
  module Types
    class TurnConfig < ::Elevenlabs::Internal::Types::Model
      field :turn_timeout, -> { Float }, optional: true, nullable: false
      field :initial_wait_time, -> { Float }, optional: true, nullable: true
      field :silence_end_call_timeout, -> { Float }, optional: true, nullable: false
      field :turn_eagerness, -> { ::Elevenlabs::Types::TurnEagerness }, optional: true, nullable: false
      field :spelling_patience, -> { ::Elevenlabs::Types::SpellingPatience }, optional: true, nullable: false
      field :speculative_turn, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :retranscribe_on_turn_timeout, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :turn_model, -> { ::Elevenlabs::Types::TurnModel }, optional: true, nullable: false
      field :interruption_ignore_terms, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :interruption_ignore_term_languages, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :merge_with_default_ignore_terms, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :transcribe_on_disabled_interruptions, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :soft_timeout_config, -> { ::Elevenlabs::Types::SoftTimeoutConfig }, optional: true, nullable: false
      field :noisy_environment_detection, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :noisy_environment_message, -> { String }, optional: true, nullable: false

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
