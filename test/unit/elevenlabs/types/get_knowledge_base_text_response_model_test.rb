# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetKnowledgeBaseTextResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'name' => 'test-value', 'metadata' => { 'created_at_unix_secs' => 1, 'last_updated_at_unix_secs' => 1, 'size_bytes' => 1 }, 'supported_usages' => ['prompt'], 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' }, 'folder_parent_id' => 'test-value', 'chunking_override' => { 'max_chunk_size' => 1, 'overlap_percentage' => 1, 'custom_separators' => ['test-value'] }, 'folder_path' => [{ 'id' => 'test-value', 'name' => 'test-value' }], 'type' => 'text', 'extracted_inner_html' => 'test-value', 'content_format' => 'html' }

    instance = ::Elevenlabs::Types::GetKnowledgeBaseTextResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
