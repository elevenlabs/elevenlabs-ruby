# frozen_string_literal: true

module Elevenlabs
  module CustomerSupport
    module Tickets
      module Types
        module CreateTicketRequestSecondaryAssignee
          extend ::Elevenlabs::Internal::Types::Union

          discriminant :type
          member -> { ::Elevenlabs::Types::TicketAiAgentAssigneeRequest }, key: 'ai_agent'
          member -> { ::Elevenlabs::Types::TicketHumanAgentAssigneeRequest }, key: 'human_agent'

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
