# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Settings
      module Types
        class GetSettingsRequest < ::Elevenlabs::Internal::Types::Model
          field :voice_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
