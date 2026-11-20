# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ResourceMetadataResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'resource_id' => 'test-value', 'resource_name' => 'test-value', 'resource_type' => 'voice', 'creator_user_id' => 'test-value', 'anonymous_access_level_override' => 'admin', 'role_to_group_ids' => { 'key' => ['test-value'] }, 'share_options' => [{ 'name' => 'test-value', 'id' => 'test-value', 'type' => 'user' }] }

    instance = ::Elevenlabs::Types::ResourceMetadataResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
