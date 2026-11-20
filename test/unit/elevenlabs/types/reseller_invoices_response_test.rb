# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ResellerInvoicesResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'invoices' => [{ 'invoice_id' => 'test-value', 'workspace_id' => 'test-value', 'workspace_name' => 'test-value', 'status' => 'paid', 'amount_cents' => 1, 'currency' => 'test-value', 'created_unix' => 1, 'paid_unix' => 1, 'pay_url' => 'test-value', 'pdf_url' => 'test-value' }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::ResellerInvoicesResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
