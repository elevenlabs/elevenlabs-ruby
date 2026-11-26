# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Project
      module Language
        module Transcript
          module Types
            class UpdateSegmentTranscriptRequest < ::Elevenlabs::Internal::Types::Model
              field :project_id, -> { String }, optional: false, nullable: false

              field :language_id, -> { String }, optional: false, nullable: false

              field :segment_id, -> { String }, optional: false, nullable: false

              field :body, -> { ::Elevenlabs::Types::DubbingTargetSegmentUpdateRequest }, optional: false, nullable: false
            end
          end
        end
      end
    end
  end
end
