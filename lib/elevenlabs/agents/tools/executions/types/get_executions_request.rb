# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tools
      module Executions
        module Types
          class GetExecutionsRequest < ::Elevenlabs::Internal::Types::Model
            field :tool_id, -> { String }, optional: false, nullable: false

            field :cursor, -> { String }, optional: true, nullable: true

            field :page_size, -> { Integer }, optional: true, nullable: true

            field :is_error, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

            field :agent_id, -> { String }, optional: true, nullable: true

            field :branch_id, -> { String }, optional: true, nullable: true

            field :start_time, -> { Float }, optional: true, nullable: true

            field :end_time, -> { Float }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
