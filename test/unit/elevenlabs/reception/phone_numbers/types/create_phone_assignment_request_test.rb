# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CreatePhoneAssignmentRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'customer_facing_agent_id' => 'test-value', 'area_codes' => ['test-value'], 'number_type' => 'local', 'idempotency_key' => 'test-value' }

    instance = ::Elevenlabs::Reception::PhoneNumbers::Types::CreatePhoneAssignmentRequest.new(wire)

    assert_equal(wire, instance.to_h.except('xi-workspace-id'))
  end
end
