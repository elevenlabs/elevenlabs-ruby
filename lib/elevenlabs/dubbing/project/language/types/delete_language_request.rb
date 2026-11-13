# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Project
      module Language
        module Types
          class DeleteLanguageRequest < ::Elevenlabs::Internal::Types::Model
            field :project_id, -> { String }, optional: false, nullable: false

            field :language_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
