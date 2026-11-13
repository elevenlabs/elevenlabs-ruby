# frozen_string_literal: true

module Elevenlabs
  module AudioIsolation
    module Types
      class ListAudioIsolationRequest < ::Elevenlabs::Internal::Types::Model
        field :page_size, -> { Integer }, optional: true, nullable: true

        field :page, -> { Integer }, optional: true, nullable: true

        field :search, -> { String }, optional: true, nullable: true
      end
    end
  end
end
