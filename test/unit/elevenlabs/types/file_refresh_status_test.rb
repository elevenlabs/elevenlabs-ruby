# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class FileRefreshStatusTest < Minitest::Test
  def test_round_trip
    wire = { 'status' => 'queued', 'enqueued_at' => 1, 'started_at' => 1, 'completed_at' => 1, 'last_synced_at' => 1, 'error_message' => 'test-value' }

    instance = ::Elevenlabs::Types::FileRefreshStatus.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
