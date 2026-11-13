# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Types
      class GetVoicesRequest < ::Elevenlabs::Internal::Types::Model
        field :voice_id, -> { String }, optional: false, nullable: false

        field :with_settings, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      end
    end
  end
end
