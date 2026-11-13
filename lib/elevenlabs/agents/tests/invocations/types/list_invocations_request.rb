# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tests
      module Invocations
        module Types
          class ListInvocationsRequest < ::Elevenlabs::Internal::Types::Model
            field :agent_id, -> { String }, optional: true, nullable: true

            field :branch_id, -> { String }, optional: true, nullable: true

            field :created_by_user_id, -> { String }, optional: true, nullable: true

            field :test_id, -> { String }, optional: true, nullable: true

            field :start_time, -> { Integer }, optional: true, nullable: true

            field :end_time, -> { Integer }, optional: true, nullable: true

            field :version_id, -> { String }, optional: true, nullable: true

            field :page_size, -> { Integer }, optional: true, nullable: true

            field :search, -> { String }, optional: true, nullable: true

            field :cursor, -> { String }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
