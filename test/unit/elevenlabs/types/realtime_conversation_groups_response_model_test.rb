# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class RealtimeConversationGroupsResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'conversation_groups' => [{ 'id' => 'test-value', 'title' => 'test-value', 'description' => 'test-value', 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' }, 'sharing' => { 'people_count' => 1, 'shared_with_everyone' => true, 'everyone_role' => 'admin' }, 'created_at_unix_secs' => 1 }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::RealtimeConversationGroupsResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
