# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ResellerInvoiceLineTest < Minitest::Test
  def test_round_trip
    wire = { 'kind' => 'plan', 'description' => 'test-value', 'quantity' => 1, 'amount_cents' => 1, 'period_start_unix' => 1, 'period_end_unix' => 1 }

    instance = ::Elevenlabs::Types::ResellerInvoiceLine.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
