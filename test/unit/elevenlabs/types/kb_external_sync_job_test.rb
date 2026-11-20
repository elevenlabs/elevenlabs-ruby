# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class KbExternalSyncJobTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'google_drive', 'folder_id' => 'test-value', 'integration_connection_id' => 'test-value', 'triggered_by' => 'on_demand', 'status' => 'queued', 'sync_type' => 'full', 'items_identified' => 1, 'items_processed' => 1, 'error_message' => 'test-value', 'started_at' => 1, 'completed_at' => 1, 'updated_at' => 1, 'id' => 'test-value', 'created_at' => 1 }

    instance = ::Elevenlabs::Types::KbExternalSyncJob.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
