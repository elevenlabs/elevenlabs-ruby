# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tests
      module Types
        class GetTestsRequest < ::Elevenlabs::Internal::Types::Model
          field :test_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
