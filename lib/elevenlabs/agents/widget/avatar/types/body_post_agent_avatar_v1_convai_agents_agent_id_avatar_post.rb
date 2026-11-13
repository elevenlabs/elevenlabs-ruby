# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Widget
      module Avatar
        module Types
          class BodyPostAgentAvatarV1ConvaiAgentsAgentIDAvatarPost < ::Elevenlabs::Internal::Types::Model
            field :avatar_file, -> { String }, optional: false, nullable: false

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
