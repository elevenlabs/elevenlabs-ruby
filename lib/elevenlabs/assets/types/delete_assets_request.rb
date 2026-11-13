# frozen_string_literal: true

module Elevenlabs
  module Assets
    module Types
      class DeleteAssetsRequest < ::Elevenlabs::Internal::Types::Model
        field :asset_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
