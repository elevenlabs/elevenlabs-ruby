# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentMessagesPersistedAgent < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::AgentMessagesPersistedAgentType }, optional: false, nullable: false
      field :agent_id, -> { String }, optional: false, nullable: false
      field :branch_id, -> { String }, optional: true, nullable: true
      field :overrides, -> { ::Elevenlabs::Types::AgentMessagesOverrides }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(agent_id, 'agent_id', min_length: 1)
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
