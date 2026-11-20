# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetAgentsPageResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'agents' => [{ 'agent_id' => 'test-value', 'name' => 'test-value', 'voice_id' => 'test-value', 'tags' => ['test-value'], 'created_at_unix_secs' => 1, 'updated_at_unix_secs' => 1, 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' }, 'last_call_time_unix_secs' => 1, 'archived' => true }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::GetAgentsPageResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
