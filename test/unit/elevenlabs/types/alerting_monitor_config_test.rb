# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AlertingMonitorConfigTest < Minitest::Test
  def test_round_trip
    wire = { 'enabled' => true, 'threshold' => 0, 'relative_increase_threshold' => 0, 'min_failure_count' => 1, 'min_history_bucket_count' => 1, 'min_sample_count' => 1, 'suspect_trigger_threshold' => 1, 'auto_resolve_after_inactive_minutes' => 1 }

    instance = ::Elevenlabs::Types::AlertingMonitorConfig.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
