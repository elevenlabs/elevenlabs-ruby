# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Types
        class CreateAgentConversationRequest < ::Elevenlabs::Internal::Types::Model
          field :agent, -> { ::Elevenlabs::Types::AgentMessagesPersistedAgent }, optional: false, nullable: false
          field :environment, -> { String }, optional: true, nullable: true
          field :user_id, -> { String }, optional: true, nullable: true
          field :dynamic_variables, -> { Object }, optional: true, nullable: false

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
