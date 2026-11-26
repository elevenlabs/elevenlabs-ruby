# frozen_string_literal: true

module Elevenlabs
  module CustomerSupport
    module SLAPolicies
      module Types
        class GetSLAPoliciesRequest < ::Elevenlabs::Internal::Types::Model
          field :policy_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
