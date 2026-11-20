# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionPhoneAssignmentTest < Minitest::Test
  def test_round_trip
    wire = { 'phone_number' => 'test-value', 'is_byo' => true, 'provider' => 'twilio', 'nanp_area_code' => 1, 'customer_facing_agent_id' => 'test-value', 'deactivated_at_unix' => 1, 'deactivation_reason' => 'tier_downgrade', 'regulatory_status' => 'held', 'regulatory_number_type' => 'local', 'regulatory_country' => 'test-value', 'id' => 'test-value', 'created_at_unix' => 1, 'updated_at_unix' => 1, 'is_active' => true, 'accepts_public_calls' => true }

    instance = ::Elevenlabs::Types::ReceptionPhoneAssignment.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
