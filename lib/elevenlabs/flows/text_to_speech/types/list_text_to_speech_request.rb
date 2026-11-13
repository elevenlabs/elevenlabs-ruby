# frozen_string_literal: true

module Elevenlabs
  module Flows
    module TextToSpeech
      module Types
        class ListTextToSpeechRequest < ::Elevenlabs::Internal::Types::Model
          field :cursor, -> { String }, optional: true, nullable: true

          field :page_size, -> { Integer }, optional: true, nullable: true

          field :status, -> { ::Elevenlabs::TextToSpeech::Types::ListTextToSpeechRequestStatus }, optional: true, nullable: true

          field :model_id, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
