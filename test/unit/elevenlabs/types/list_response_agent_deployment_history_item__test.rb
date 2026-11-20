# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ListResponseAgentDeploymentHistoryItemTest < Minitest::Test
  def test_round_trip
    wire = { 'meta' => { 'total' => 1, 'page' => 1, 'page_size' => 1 }, 'results' => [{ 'id' => 'test-value', 'traffic_percentage_branch_id_map' => { 'key' => 1 }, 'deployed_at_unix_secs' => 1, 'is_active' => true, 'source' => 'manual', 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' } }] }

    instance = ::Elevenlabs::Types::ListResponseAgentDeploymentHistoryItem.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
