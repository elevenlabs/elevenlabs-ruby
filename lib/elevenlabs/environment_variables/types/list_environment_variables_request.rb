# frozen_string_literal: true

module Elevenlabs
  module EnvironmentVariables
    module Types
      class ListEnvironmentVariablesRequest < ::Elevenlabs::Internal::Types::Model
        field :cursor, -> { String }, optional: true, nullable: true

        field :page_size, -> { Integer }, optional: true, nullable: true

        field :label, -> { String }, optional: true, nullable: true

        field :environment, -> { String }, optional: true, nullable: true

        field :type, -> { ::Elevenlabs::EnvironmentVariables::Types::ListEnvironmentVariablesRequestType }, optional: true, nullable: true
      end
    end
  end
end
