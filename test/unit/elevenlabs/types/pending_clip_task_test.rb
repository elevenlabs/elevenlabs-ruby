# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PendingClipTaskTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'preprocessing', 'progress' => 1, 'started_at_ms' => 1, 'updated_at_ms' => 1, 'metadata' => {} }

    instance = ::Elevenlabs::Types::PendingClipTask.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
