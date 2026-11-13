# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Pvc
      module Samples
        module Types
          class DeleteSamplesRequest < ::Elevenlabs::Internal::Types::Model
            field :voice_id, -> { String }, optional: false, nullable: false

            field :sample_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
