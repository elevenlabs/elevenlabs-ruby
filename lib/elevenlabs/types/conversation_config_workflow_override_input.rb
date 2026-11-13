# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationConfigWorkflowOverrideInput < ::Elevenlabs::Internal::Types::Model
      field :text_only, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :max_duration_seconds, -> { Integer }, optional: true, nullable: true
      field :client_events, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ClientEvent] }, optional: true, nullable: true
      field :file_input, -> { ::Elevenlabs::Types::FileInputConfigWorkflowOverride }, optional: true, nullable: true
      field :monitoring_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :monitoring_events, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ClientEvent] }, optional: true, nullable: true
      field :dtmf_input_settings, -> { ::Elevenlabs::Types::DtmfInputConfig }, optional: true, nullable: false
      field :background_sound, -> { ::Elevenlabs::Types::BackgroundSoundConfigWorkflowOverride }, optional: true, nullable: true
      field :source_attribution, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

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
