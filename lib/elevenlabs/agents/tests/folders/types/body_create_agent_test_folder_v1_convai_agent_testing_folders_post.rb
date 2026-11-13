# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tests
      module Folders
        module Types
          class BodyCreateAgentTestFolderV1ConvaiAgentTestingFoldersPost < ::Elevenlabs::Internal::Types::Model
            field :name, -> { String }, optional: false, nullable: false
            field :parent_folder_id, -> { String }, optional: true, nullable: true

            def self.load(str)
              coerce(::JSON.parse(str, symbolize_names: true))
            end

            def self.dump(value)
              coerced = coerce(value)
              ::JSON.generate(coerced.nil? || !coerced.respond_to?(:to_h) ? coerced : coerced.to_h)
            end
          end
        end
      end
    end
  end
end
