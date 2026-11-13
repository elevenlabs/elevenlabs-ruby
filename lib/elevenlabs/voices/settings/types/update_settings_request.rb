# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Settings
      module Types
        class UpdateSettingsRequest < ::Elevenlabs::Internal::Types::Model
          field :voice_id, -> { String }, optional: false, nullable: false

          field :body, -> { ::Elevenlabs::Types::BodyTextToSpeechFullVoiceSettings }, optional: false, nullable: false
        end
      end
    end
  end
end
