# frozen_string_literal: true

module Elevenlabs
  module SpeechEngine
    module Types
      class UpdateSpeechEngineRequest < ::Elevenlabs::Internal::Types::Model
        field :name, -> { String }, optional: true, nullable: true
        field :speech_engine, -> { ::Elevenlabs::Types::SpeechEngineConfig }, optional: true, nullable: false
        field :asr, -> { ::Elevenlabs::Types::AsrConversationalConfig }, optional: true, nullable: false
        field :tts, -> { ::Elevenlabs::Types::TtsConversationalConfigInput }, optional: true, nullable: false
        field :turn, -> { ::Elevenlabs::Types::BaseTurnConfig }, optional: true, nullable: false
        field :vad, -> { ::Elevenlabs::Types::VadConfig }, optional: true, nullable: false
        field :conversation, -> { ::Elevenlabs::Types::ConversationConfigInput }, optional: true, nullable: false
        field :privacy, -> { ::Elevenlabs::Types::PrivacyConfigInput }, optional: true, nullable: false
        field :call_limits, -> { ::Elevenlabs::Types::AgentCallLimits }, optional: true, nullable: false
        field :auth, -> { ::Elevenlabs::Types::SpeechEngineAuthConfig }, optional: true, nullable: false
        field :language, -> { String }, optional: true, nullable: true
        field :cascade_timeout_seconds, -> { Float }, optional: true, nullable: true
        field :tags, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
        field :overrides, -> { ::Elevenlabs::Types::SpeechEngineConversationInitiationClientDataConfig }, optional: true, nullable: false

        def validate!
          Validator.validate_number!(cascade_timeout_seconds, 'cascade_timeout_seconds', min: 2, max: 15)
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
end
