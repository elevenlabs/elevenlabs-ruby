# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetKnowledgeBaseFolderResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'name' => 'test-value', 'metadata' => { 'created_at_unix_secs' => 1, 'last_updated_at_unix_secs' => 1, 'size_bytes' => 1 }, 'supported_usages' => ['prompt'], 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' }, 'folder_parent_id' => 'test-value', 'chunking_override' => { 'max_chunk_size' => 1, 'overlap_percentage' => 1, 'custom_separators' => ['test-value'] }, 'folder_path' => [{ 'id' => 'test-value', 'name' => 'test-value' }], 'type' => 'folder', 'children_count' => 1, 'document_count' => 1, 'auto_sync_info' => { 'minimum_frequency_days' => 1, 'auto_remove' => true, 'consec_failures' => 0, 'next_refresh_by' => 1 }, 'external_sync_info' => { 'type' => 'google_drive', 'source_entity_id' => 'test-value', 'integration_connection_id' => 'test-value', 'root_folder_id' => 'test-value', 'sync_cursor' => 'test-value', 'last_sync_at' => 1 }, 'is_frozen' => true, 'active_sync_job' => { 'type' => 'google_drive', 'folder_id' => 'test-value', 'integration_connection_id' => 'test-value', 'triggered_by' => 'on_demand', 'status' => 'queued', 'sync_type' => 'full', 'items_identified' => 1, 'items_processed' => 1, 'error_message' => 'test-value', 'started_at' => 1, 'completed_at' => 1, 'updated_at' => 1, 'id' => 'test-value', 'created_at' => 1 } }

    instance = ::Elevenlabs::Types::GetKnowledgeBaseFolderResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
