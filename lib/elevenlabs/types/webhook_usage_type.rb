# frozen_string_literal: true

module Elevenlabs
  module Types
    module WebhookUsageType
      extend ::Elevenlabs::Internal::Types::Enum

      CONV_AI_AGENT_SETTINGS = :'ConvAI Agent Settings'
      CONV_AI_SETTINGS = :'ConvAI Settings'
      VOICE_LIBRARY_REMOVAL_NOTICES = :'Voice Library Removal Notices'
      SPEECH_TO_TEXT = :'Speech to Text'
      AGENT_QA_EVALUATIONS = :'Agent QA Evaluations'
      CONV_AI_ALERTING = :'ConvAI Alerting'
      FLOWS = :Flows
      DUBBING = :Dubbing

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
