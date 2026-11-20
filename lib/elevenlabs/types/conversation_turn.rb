# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationTurn < ::Elevenlabs::Internal::Types::Model
      field :turn_id, -> { String }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::AgentOutputStatus }, optional: false, nullable: false
      field :output, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TextOutputItem] }, optional: true, nullable: false
      field :error, -> { ::Elevenlabs::Types::AgentOutputError }, optional: true, nullable: true
      field :required_actions, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ClientToolCallRequiredAction] }, optional: true, nullable: false
      field :stream_cursor, -> { String }, optional: true, nullable: true

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
