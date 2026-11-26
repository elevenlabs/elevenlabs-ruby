# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Types
        class SendConversationMessageStreamRequest < ::Elevenlabs::Internal::Types::Model
          field :conversation_id, -> { String }, optional: false, nullable: false
          field :input, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Agents::Conversations::Types::SendConversationMessageStreamRequestInputItem] }, optional: false, nullable: false

          def validate!
            ::Elevenlabs::Validator.validate_array!(input, 'input', min_items: 1)
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
