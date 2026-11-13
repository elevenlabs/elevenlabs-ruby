# frozen_string_literal: true

module Elevenlabs
  module EnvironmentVariables
    module Types
      class DeleteEnvironmentVariablesRequest < ::Elevenlabs::Internal::Types::Model
        field :env_var_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
