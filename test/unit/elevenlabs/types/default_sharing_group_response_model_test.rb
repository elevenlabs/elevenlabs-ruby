# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class DefaultSharingGroupResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'group' => { 'name' => 'test-value', 'id' => 'test-value', 'members' => ['test-value'], 'permissions' => ['text_to_speech'], 'group_usage_limit' => 1, 'group_pvc_limit' => 1, 'group_concurrency_limit' => 1, 'group_dubbing_concurrency_limit' => 1, 'group_music_concurrency_limit' => 1, 'character_count' => 1, 'is_scim_synced' => true, 'scim_group' => { 'scim_external_id' => 'test-value', 'display_name' => 'test-value', 'created_at_unix' => 1, 'updated_at_unix' => 1, 'seat_type' => 'workspace_admin' }, 'scim_frozen' => true }, 'permission_level' => 'admin' }

    instance = ::Elevenlabs::Types::DefaultSharingGroupResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
