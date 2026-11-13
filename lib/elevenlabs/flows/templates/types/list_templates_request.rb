# frozen_string_literal: true

module Elevenlabs
  module Flows
    module Templates
      module Types
        class ListTemplatesRequest < ::Elevenlabs::Internal::Types::Model
          field :cursor, -> { String }, optional: true, nullable: true

          field :page_size, -> { Integer }, optional: true, nullable: true

          field :versions_per_template, -> { Integer }, optional: true, nullable: true

          field :search, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
