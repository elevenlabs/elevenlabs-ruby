# frozen_string_literal: true

module Elevenlabs
  module Environments
    module Types
      class DeleteEnvironmentsRequest < ::Elevenlabs::Internal::Types::Model
        field :environment, -> { String }, optional: false, nullable: false
      end
    end
  end
end
