# frozen_string_literal: true

module Elevenlabs
  module TextToVoice
    module Preview
      module Types
        class StreamPreviewRequest < ::Elevenlabs::Internal::Types::Model
          field :generated_voice_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
