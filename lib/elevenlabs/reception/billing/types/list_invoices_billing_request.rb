# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Billing
      module Types
        class ListInvoicesBillingRequest < ::Elevenlabs::Internal::Types::Model
          field :cursor, -> { String }, optional: true, nullable: true

          field :page_size, -> { Integer }, optional: true, nullable: true
        end
      end
    end
  end
end
