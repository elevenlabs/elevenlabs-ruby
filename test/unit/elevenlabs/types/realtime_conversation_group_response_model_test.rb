# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class RealtimeConversationGroupResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'title' => 'test-value', 'description' => 'test-value', 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' }, 'sharing' => { 'people_count' => 1, 'shared_with_everyone' => true, 'everyone_role' => 'admin' }, 'created_at_unix_secs' => 1 }

    instance = ::Elevenlabs::Types::RealtimeConversationGroupResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
