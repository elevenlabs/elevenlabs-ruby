# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tests
      module Invocations
        module Types
          class CancelInvocationsRequest < ::Elevenlabs::Internal::Types::Model
            field :test_invocation_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
