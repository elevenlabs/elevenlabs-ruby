# frozen_string_literal: true

module Elevenlabs
  module Types
    class ResellerInvoiceLine < ::Elevenlabs::Internal::Types::Model
      field :kind, -> { ::Elevenlabs::Types::ResellerInvoiceLineKind }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :quantity, -> { Integer }, optional: true, nullable: true
      field :amount_cents, -> { Integer }, optional: false, nullable: false
      field :period_start_unix, -> { Integer }, optional: false, nullable: false
      field :period_end_unix, -> { Integer }, optional: false, nullable: false

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
