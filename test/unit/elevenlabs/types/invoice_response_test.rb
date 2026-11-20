# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class InvoiceResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'amount_due_cents' => 1, 'subtotal_cents' => 1, 'tax_cents' => 1, 'discount_percent_off' => 1, 'discount_amount_off' => 1, 'discounts' => [{ 'discount_percent_off' => 1, 'discount_amount_off' => 1 }], 'next_payment_attempt_unix' => 1, 'payment_intent_status' => 'canceled', 'payment_intent_statusses' => ['canceled'] }

    instance = ::Elevenlabs::Types::InvoiceResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
