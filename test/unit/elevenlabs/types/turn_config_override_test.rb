# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TurnConfigOverrideTest < Minitest::Test
  def test_round_trip
    wire = { 'soft_timeout_config' => { 'message' => 'test-value', 'additional_soft_timeout_messages' => ['test-value'] }, 'noisy_environment_message' => 'test-value' }

    instance = ::Elevenlabs::Types::TurnConfigOverride.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
