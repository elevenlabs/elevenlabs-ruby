# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionProvisionResellerWorkspaceRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'business_name' => 'test-value', 'vertical' => 'salon_barbershop', 'subscription' => { 'tier_id' => 'test-value', 'billing_period' => 'monthly_period' }, 'phone_number' => 'test-value', 'members' => [{ 'email' => 'test-value', 'role' => 'workspace_admin' }], 'complete_onboarding' => true, 'idempotency_key' => 'test-value' }

    instance = ::Elevenlabs::Reception::Workspaces::Types::ReceptionProvisionResellerWorkspaceRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
