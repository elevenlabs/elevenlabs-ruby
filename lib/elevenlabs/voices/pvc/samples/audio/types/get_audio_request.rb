# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Pvc
      module Samples
        module Audio
          module Types
            class GetAudioRequest < ::Elevenlabs::Internal::Types::Model
              field :voice_id, -> { String }, optional: false, nullable: false

              field :sample_id, -> { String }, optional: false, nullable: false

              field :remove_background_noise, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
            end
          end
        end
      end
    end
  end
end
