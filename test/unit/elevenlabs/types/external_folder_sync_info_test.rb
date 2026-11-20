# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ExternalFolderSyncInfoTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'google_drive', 'source_entity_id' => 'test-value', 'integration_connection_id' => 'test-value', 'root_folder_id' => 'test-value', 'sync_cursor' => 'test-value', 'last_sync_at' => 1 }

    instance = ::Elevenlabs::Types::ExternalFolderSyncInfo.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
