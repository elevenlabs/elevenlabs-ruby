# frozen_string_literal: true

module Elevenlabs
  module CustomerSupport
    module Tickets
      module Types
        module CreateTicketMessageRequestAuthor
          extend ::Elevenlabs::Internal::Types::Union

          discriminant :type
          member -> { ::Elevenlabs::Types::TicketHumanAgentAuthorRequest }, key: 'human_agent'
          member -> { ::Elevenlabs::Types::TicketRequesterAuthorRequest }, key: 'requester'

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
