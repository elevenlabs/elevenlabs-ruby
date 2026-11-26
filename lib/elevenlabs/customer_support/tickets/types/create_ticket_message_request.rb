# frozen_string_literal: true

module Elevenlabs
  module CustomerSupport
    module Tickets
      module Types
        class CreateTicketMessageRequest < ::Elevenlabs::Internal::Types::Model
          field :ticket_id, -> { String }, optional: false, nullable: false
          field :author, -> { ::Elevenlabs::CustomerSupport::Tickets::Types::CreateTicketMessageRequestAuthor }, optional: false, nullable: false
          field :body, -> { String }, optional: false, nullable: false
          field :visibility, -> { ::Elevenlabs::Types::TicketEventVisibility }, optional: false, nullable: false
          field :status, -> { ::Elevenlabs::Types::TicketStatus }, optional: true, nullable: false

          def validate!
            ::Elevenlabs::Validator.validate_string!(body, 'body', min_length: 1)
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
