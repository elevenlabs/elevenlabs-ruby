# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CompactionSettingsWorkflowOverrideTest < Minitest::Test
  def test_round_trip
    wire = { 'enabled' => true, 'soft_trigger_fraction' => 1, 'tail_size' => 1, 'min_reclaimable_tokens' => 1 }

    instance = ::Elevenlabs::Types::CompactionSettingsWorkflowOverride.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
