# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Collections
      module Types
        class GetCollectionsRequest < ::Elevenlabs::Internal::Types::Model
          field :collection_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
