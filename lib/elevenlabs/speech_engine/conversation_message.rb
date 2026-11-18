# frozen_string_literal: true

module Elevenlabs
  module SpeechEngine
    # A single message in a Speech Engine conversation transcript.
    #
    # Hand-written (see +.fernignore+): the server-side session surface is not part
    # of the generated client. Mirrors +ConversationMessage+ in the PHP/Python/TS SDKs.
    class ConversationMessage
      # @return [String] Either "user" or "agent".
      attr_reader :role

      # @return [String] The text content of the message.
      attr_reader :content

      def initialize(role, content)
        @role = role
        @content = content
      end
    end
  end
end
