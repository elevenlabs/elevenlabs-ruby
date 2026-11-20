# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetTestsPageResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'tests' => [{ 'id' => 'test-value', 'name' => 'test-value', 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' }, 'created_at_unix_secs' => 1, 'last_updated_at_unix_secs' => 1, 'type' => 'llm', 'entity_type' => 'test', 'folder_parent_id' => 'test-value', 'folder_path' => [{ 'id' => 'test-value', 'name' => 'test-value' }], 'children_count' => 1, 'conversation_initiation_source' => 'unknown' }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::GetTestsPageResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
