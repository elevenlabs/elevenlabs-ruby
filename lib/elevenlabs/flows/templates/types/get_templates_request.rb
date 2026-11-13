# frozen_string_literal: true

module Elevenlabs
  module Flows
    module Templates
      module Types
        class GetTemplatesRequest < ::Elevenlabs::Internal::Types::Model
          field :template_id, -> { String }, optional: false, nullable: false

          field :versions_per_template, -> { Integer }, optional: true, nullable: true
        end
      end
    end
  end
end
