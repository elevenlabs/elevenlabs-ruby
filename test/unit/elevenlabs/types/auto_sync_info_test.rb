# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AutoSyncInfoTest < Minitest::Test
  def test_round_trip
    wire = { 'minimum_frequency_days' => 1, 'auto_remove' => true, 'consec_failures' => 0, 'next_refresh_by' => 1 }

    instance = ::Elevenlabs::Types::AutoSyncInfo.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
