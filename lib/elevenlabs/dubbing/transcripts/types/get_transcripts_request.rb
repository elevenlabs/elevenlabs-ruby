# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Transcripts
      module Types
        class GetTranscriptsRequest < ::Elevenlabs::Internal::Types::Model
          field :dubbing_id, -> { String }, optional: false, nullable: false

          field :language_code, -> { String }, optional: false, nullable: false

          field :format_type, -> { ::Elevenlabs::Dubbing::Transcripts::Types::GetTranscriptsRequestFormatType }, optional: false, nullable: false
        end
      end
    end
  end
end
