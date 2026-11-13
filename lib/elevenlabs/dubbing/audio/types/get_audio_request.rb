# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Audio
      module Types
        class GetAudioRequest < ::Elevenlabs::Internal::Types::Model
          field :dubbing_id, -> { String }, optional: false, nullable: false

          field :language_code, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
