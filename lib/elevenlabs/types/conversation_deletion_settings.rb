# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationDeletionSettings < ::Elevenlabs::Internal::Types::Model
      field :deletion_time_unix_secs, -> { Integer }, optional: true, nullable: true
      field :deleted_logs_at_time_unix_secs, -> { Integer }, optional: true, nullable: true
      field :deleted_audio_at_time_unix_secs, -> { Integer }, optional: true, nullable: true
      field :deleted_transcript_at_time_unix_secs, -> { Integer }, optional: true, nullable: true
      field :delete_transcript_and_pii, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :delete_audio, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
