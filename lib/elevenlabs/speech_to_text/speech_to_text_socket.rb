# frozen_string_literal: true

module Elevenlabs
  module SpeechToText
    # A WebSocket connection to the `speech_to_text` channel (`/v1/speech-to-text/realtime`).
    #
    # Received messages queue for `#recv` and `#each` until `#start_listening` hands them to the
    # handlers registered with `#on`.
    class SpeechToTextSocket
      include ::Elevenlabs::Internal::WebSocket::Channel

      RECEIVE_TYPES = [
        [::Elevenlabs::Types::DiarizedTranscript, { 'message_type' => 'diarized_transcript' }, %w[segment_index text words]],
        [::Elevenlabs::Types::SessionStarted, { 'message_type' => 'session_started' }, %w[session_id config]],
        [::Elevenlabs::Types::SpeakersMerged, { 'message_type' => 'speakers_merged' }, %w[from_speaker_id to_speaker_id]],
        [::Elevenlabs::Types::RedactedTranscript, { 'message_type' => 'redacted_transcript' }, %w[text redacted_text]],
        [::Elevenlabs::Types::PartialTranscript, { 'message_type' => 'partial_transcript' }, ['text']],
        [::Elevenlabs::Types::CommittedTranscript, { 'message_type' => 'committed_transcript' }, ['text']],
        [::Elevenlabs::Types::CommittedTranscriptWithTimestamps, { 'message_type' => 'committed_transcript_with_timestamps' }, ['text']],
        [::Elevenlabs::Types::CommittedTranscriptEntities, { 'message_type' => 'committed_transcript_entities' }, ['text']],
        [::Elevenlabs::Types::ScribeWarning, { 'message_type' => 'warning' }, ['warning']],
        [::Elevenlabs::Types::ScribeError, { 'message_type' => 'error' }, ['error']],
        [::Elevenlabs::Types::ScribeAuthError, { 'message_type' => 'auth_error' }, ['error']],
        [::Elevenlabs::Types::ScribeQuotaExceededError, { 'message_type' => 'quota_exceeded' }, ['error']],
        [::Elevenlabs::Types::ScribeThrottledError, { 'message_type' => 'commit_throttled' }, ['error']],
        [::Elevenlabs::Types::ScribeUnacceptedTermsError, { 'message_type' => 'unaccepted_terms' }, ['error']],
        [::Elevenlabs::Types::ScribeRateLimitedError, { 'message_type' => 'rate_limited' }, ['error']],
        [::Elevenlabs::Types::ScribeQueueOverflowError, { 'message_type' => 'queue_overflow' }, ['error']],
        [::Elevenlabs::Types::ScribeResourceExhaustedError, { 'message_type' => 'resource_exhausted' }, ['error']],
        [::Elevenlabs::Types::ScribeSessionTimeLimitExceededError, { 'message_type' => 'session_time_limit_exceeded' }, ['error']],
        [::Elevenlabs::Types::ScribeInputError, { 'message_type' => 'input_error' }, ['error']],
        [::Elevenlabs::Types::ScribeInvalidRequestError, { 'message_type' => 'invalid_request' }, ['error']],
        [::Elevenlabs::Types::ScribeChunkSizeExceededError, { 'message_type' => 'chunk_size_exceeded' }, ['error']],
        [::Elevenlabs::Types::ScribeInsufficientAudioActivityError, { 'message_type' => 'insufficient_audio_activity' }, ['error']],
        [::Elevenlabs::Types::ScribeTranscriberError, { 'message_type' => 'transcriber_error' }, ['error']],
      ].freeze

      UNION_TYPES = [::Elevenlabs::Types::ReceiveTranscription].freeze

      # Sends a `Input Audio Chunk` message.
      #
      # @param message [::Elevenlabs::Types::InputAudioChunk, Hash]
      # @raise [::Elevenlabs::Errors::WebSocketError] The connection is not open.
      # @return [void]
      def send_publish(message)
        send_json(message)
      end

      private

      def decode(text)
        data = parse_json(text)
        return [:raw, text] if data.equal?(NOT_JSON)

        match_json(data, RECEIVE_TYPES, UNION_TYPES) || [:unknown, data]
      end
    end
  end
end
