# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class LeadsProgressTest < Minitest::Test
  def test_round_trip
    wire = { 'total' => 1, 'uncalled' => 1, 'leads_needing_attention' => 1, 'active' => 1, 'finished' => 1, 'finished_by_disposition' => { 'key' => 1 } }

    instance = ::Elevenlabs::Types::LeadsProgress.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
