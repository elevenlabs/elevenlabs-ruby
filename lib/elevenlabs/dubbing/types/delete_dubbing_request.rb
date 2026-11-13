# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Types
      class DeleteDubbingRequest < ::Elevenlabs::Internal::Types::Model
        field :dubbing_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
