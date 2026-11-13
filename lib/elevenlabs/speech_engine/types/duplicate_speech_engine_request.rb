# frozen_string_literal: true

module Elevenlabs
  module SpeechEngine
    module Types
      class DuplicateSpeechEngineRequest < ::Elevenlabs::Internal::Types::Model
        field :speech_engine_id, -> { String }, optional: false, nullable: false

        field :body, -> { ::Elevenlabs::Types::DuplicateSpeechEngineRequest }, optional: true, nullable: false
      end
    end
  end
end
