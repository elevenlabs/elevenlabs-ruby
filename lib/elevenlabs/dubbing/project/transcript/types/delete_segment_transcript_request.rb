# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Project
      module Transcript
        module Types
          class DeleteSegmentTranscriptRequest < ::Elevenlabs::Internal::Types::Model
            field :project_id, -> { String }, optional: false, nullable: false

            field :segment_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
