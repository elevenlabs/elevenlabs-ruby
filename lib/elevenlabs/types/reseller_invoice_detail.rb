# frozen_string_literal: true

module Elevenlabs
  module Types
    class ResellerInvoiceDetail < ::Elevenlabs::Internal::Types::Model
      field :invoice_id, -> { String }, optional: false, nullable: false
      field :workspace_id, -> { String }, optional: false, nullable: true
      field :workspace_name, -> { String }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::ResellerInvoiceStatus }, optional: false, nullable: false
      field :amount_cents, -> { Integer }, optional: false, nullable: false
      field :currency, -> { String }, optional: false, nullable: false
      field :created_unix, -> { Integer }, optional: false, nullable: false
      field :paid_unix, -> { Integer }, optional: true, nullable: true
      field :pay_url, -> { String }, optional: true, nullable: true
      field :pdf_url, -> { String }, optional: true, nullable: true
      field :lines, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ResellerInvoiceLine] }, optional: false, nullable: false

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
