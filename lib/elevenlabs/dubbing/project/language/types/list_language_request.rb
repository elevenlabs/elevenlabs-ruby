# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Project
      module Language
        module Types
          class ListLanguageRequest < ::Elevenlabs::Internal::Types::Model
            field :project_id, -> { String }, optional: false, nullable: false

            field :cursor, -> { String }, optional: true, nullable: true

            field :page_size, -> { Integer }, optional: true, nullable: true

            field :status, -> { String }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
