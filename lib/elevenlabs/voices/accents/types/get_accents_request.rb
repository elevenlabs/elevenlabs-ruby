# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Accents
      module Types
        class GetAccentsRequest < ::Elevenlabs::Internal::Types::Model
          field :language, -> { String }, optional: true, nullable: true

          field :model_id, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
