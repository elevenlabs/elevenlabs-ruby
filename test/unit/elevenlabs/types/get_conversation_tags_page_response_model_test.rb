# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetConversationTagsPageResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'conversation_tags' => [{ 'tag_id' => 'test-value', 'workspace_id' => 'test-value', 'owner_user_id' => 'test-value', 'title' => 'test-value', 'description' => 'test-value', 'created_at_unix_secs' => 1 }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::GetConversationTagsPageResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
