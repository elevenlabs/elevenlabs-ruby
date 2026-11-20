# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WorkspaceNowTest < Minitest::Test
  def test_round_trip
    wire = { 'today' => { 'year' => 2026, 'month' => 1, 'day' => 1 }, 'hour' => 0, 'minute' => 0, 'fetched_at_ms' => 1 }

    instance = ::Elevenlabs::Types::WorkspaceNow.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
