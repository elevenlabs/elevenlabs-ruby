# frozen_string_literal: true

module Elevenlabs
  module Types
    module WorkspaceWebhookEventType
      extend ::Elevenlabs::Internal::Types::Enum

      VOICE_LIBRARY_REMOVAL_NOTICE = :voice_library_removal_notice
      SPEECH_TO_TEXT = :speech_to_text
      AGENT_QA = :agent_qa
      FLOWS = :flows

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
