# frozen_string_literal: true

module Elevenlabs
  module Types
    class SpeechEngineResponse < ::Elevenlabs::Internal::Types::Model
      field :speech_engine_id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :speech_engine, -> { ::Elevenlabs::Types::SpeechEngineConfig }, optional: false, nullable: false
      field :asr, -> { ::Elevenlabs::Types::AsrConversationalConfig }, optional: false, nullable: false
      field :tts, -> { ::Elevenlabs::Types::TtsConversationalConfigOutput }, optional: false, nullable: false
      field :turn, -> { ::Elevenlabs::Types::BaseTurnConfig }, optional: false, nullable: false
      field :vad, -> { ::Elevenlabs::Types::VadConfig }, optional: false, nullable: false
      field :conversation, -> { ::Elevenlabs::Types::ConversationConfigOutput }, optional: false, nullable: false
      field :privacy, -> { ::Elevenlabs::Types::PrivacyConfigOutput }, optional: false, nullable: false
      field :call_limits, -> { ::Elevenlabs::Types::AgentCallLimits }, optional: false, nullable: false
      field :auth, -> { ::Elevenlabs::Types::SpeechEngineAuthConfig }, optional: false, nullable: false
      field :language, -> { String }, optional: false, nullable: false
      field :cascade_timeout_seconds, -> { Float }, optional: false, nullable: false
      field :tags, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :overrides, -> { ::Elevenlabs::Types::SpeechEngineConversationInitiationClientDataConfig }, optional: false, nullable: false
      field :metadata, -> { ::Elevenlabs::Types::AgentMetadataDbModel }, optional: false, nullable: false
      field :access_info, -> { ::Elevenlabs::Types::ResourceAccessInfo }, optional: true, nullable: false

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
