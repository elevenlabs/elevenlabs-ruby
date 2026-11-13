# frozen_string_literal: true

module Elevenlabs
  module AudioNative
    module Types
      class GetSettingsAudioNativeRequest < ::Elevenlabs::Internal::Types::Model
        field :project_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
