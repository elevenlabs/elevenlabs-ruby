# frozen_string_literal: true

module Elevenlabs
  module CustomerSupport
    module SLAPolicies
      module Types
        class ListSLAPoliciesRequest < ::Elevenlabs::Internal::Types::Model
          field :include_archived, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

          field :page_size, -> { Integer }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
