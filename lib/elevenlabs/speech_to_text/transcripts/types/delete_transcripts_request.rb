# frozen_string_literal: true

module Elevenlabs
  module SpeechToText
    module Transcripts
      module Types
        class DeleteTranscriptsRequest < ::Elevenlabs::Internal::Types::Model
          field :transcription_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
