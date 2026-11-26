# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CreateTicketSLAPolicyRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'description' => 'test-value', 'targets' => [{ 'metric' => 'first_response', 'priority' => 'low', 'duration_secs' => 1 }] }

    instance = ::Elevenlabs::CustomerSupport::SLAPolicies::Types::CreateTicketSLAPolicyRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
