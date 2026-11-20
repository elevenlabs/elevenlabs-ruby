# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyGetWorkspaceCostUsageV1WorkspaceAnalyticsUsagePostTest < Minitest::Test
  def test_round_trip
    wire = { 'start_time' => 1_577_836_800_000, 'end_time' => 1_577_836_800_000, 'interval_seconds' => 86_400, 'group_by' => ['model'], 'filters' => [{ 'column' => 'model', 'operation' => 'eq', 'values' => ['test-value'] }] }

    instance = ::Elevenlabs::Workspace::Usage::Types::BodyGetWorkspaceCostUsageV1WorkspaceAnalyticsUsagePost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
