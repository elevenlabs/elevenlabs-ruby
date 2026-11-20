# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TransferBranchInfoTrafficSplitTest < Minitest::Test
  def test_round_trip
    wire = { 'branch_reason' => 'traffic_split', 'branch_id' => 'test-value', 'traffic_percentage' => 1 }

    instance = ::Elevenlabs::Types::TransferBranchInfoTrafficSplit.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
