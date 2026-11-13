# frozen_string_literal: true

module Elevenlabs
  module Flows
    module Templates
      module Runs
        module Types
          class ListRunsRequest < ::Elevenlabs::Internal::Types::Model
            field :template_id, -> { String }, optional: false, nullable: false

            field :cursor, -> { String }, optional: true, nullable: true

            field :page_size, -> { Integer }, optional: true, nullable: true

            field :version_id, -> { String }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
