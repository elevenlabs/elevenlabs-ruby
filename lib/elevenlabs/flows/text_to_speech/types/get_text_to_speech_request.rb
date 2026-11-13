# frozen_string_literal: true

module Elevenlabs
  module Flows
    module TextToSpeech
      module Types
        class GetTextToSpeechRequest < ::Elevenlabs::Internal::Types::Model
          field :generation_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
