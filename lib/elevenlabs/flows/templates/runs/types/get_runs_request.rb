# frozen_string_literal: true

module Elevenlabs
  module Flows
    module Templates
      module Runs
        module Types
          class GetRunsRequest < ::Elevenlabs::Internal::Types::Model
            field :template_id, -> { String }, optional: false, nullable: false

            field :run_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
