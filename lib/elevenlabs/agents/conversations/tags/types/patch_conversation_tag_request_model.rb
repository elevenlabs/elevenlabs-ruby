# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Tags
        module Types
          class PatchConversationTagRequestModel < ::Elevenlabs::Internal::Types::Model
            field :title, -> { String }, optional: true, nullable: true
            field :description, -> { String }, optional: true, nullable: true

            def validate!
              ::Elevenlabs::Validator.validate_string!(title, 'title', min_length: 1, max_length: 120)
              ::Elevenlabs::Validator.validate_string!(description, 'description', max_length: 1000)
            end

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
