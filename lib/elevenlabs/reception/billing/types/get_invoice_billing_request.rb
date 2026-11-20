# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Billing
      module Types
        class GetInvoiceBillingRequest < ::Elevenlabs::Internal::Types::Model
          field :invoice_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
