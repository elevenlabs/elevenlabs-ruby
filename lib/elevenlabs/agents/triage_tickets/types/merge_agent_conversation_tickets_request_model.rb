# frozen_string_literal: true

module Elevenlabs
  module Agents
    module TriageTickets
      module Types
        class MergeAgentConversationTicketsRequestModel < ::Elevenlabs::Internal::Types::Model
          field :source_ticket_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false

          def validate!
            ::Elevenlabs::Validator.validate_array!(source_ticket_ids, 'source_ticket_ids', min_items: 1, max_items: 50)
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
