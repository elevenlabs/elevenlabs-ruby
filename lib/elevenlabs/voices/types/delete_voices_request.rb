# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Types
      class DeleteVoicesRequest < ::Elevenlabs::Internal::Types::Model
        field :voice_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
