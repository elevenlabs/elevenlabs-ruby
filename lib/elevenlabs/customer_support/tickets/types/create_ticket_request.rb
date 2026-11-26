# frozen_string_literal: true

module Elevenlabs
  module CustomerSupport
    module Tickets
      module Types
        class CreateTicketRequest < ::Elevenlabs::Internal::Types::Model
          field :requester, -> { ::Elevenlabs::CustomerSupport::Tickets::Types::CreateTicketRequestRequester }, optional: false, nullable: false
          field :author, -> { ::Elevenlabs::CustomerSupport::Tickets::Types::CreateTicketRequestAuthor }, optional: false, nullable: false
          field :subject, -> { String }, optional: false, nullable: false
          field :description, -> { String }, optional: true, nullable: true
          field :priority, -> { ::Elevenlabs::Types::TicketPriority }, optional: true, nullable: false
          field :deadline_at_unix_secs, -> { Integer }, optional: true, nullable: true
          field :tag_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
          field :assignee, -> { ::Elevenlabs::CustomerSupport::Tickets::Types::CreateTicketRequestAssignee }, optional: true, nullable: true
          field :secondary_assignee, -> { ::Elevenlabs::CustomerSupport::Tickets::Types::CreateTicketRequestSecondaryAssignee }, optional: true, nullable: true
          field :subscribers, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TicketSubscriberRequest] }, optional: true, nullable: false

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
