# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WorkspaceServiceAccountListResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'service-accounts' => [{ 'service_account_user_id' => 'test-value', 'name' => 'test-value', 'created_at_unix' => 1, 'api-keys' => [{ 'name' => 'test-value', 'hint' => 'test-value', 'key_id' => 'test-value', 'service_account_user_id' => 'test-value', 'created_at_unix' => 1, 'is_disabled' => true, 'permissions' => ['text_to_speech'], 'disable_reason' => 'trial_ended', 'character_limit' => 1, 'character_count' => 1, 'hashed_xi_api_key' => 'test-value', 'allowed_ips' => ['test-value'], 'third_party_disable_allowed' => true, 'platform_limits' => { 'credits' => { 'limit' => 1, 'usage' => 1 }, 'pvc' => { 'limit' => 1 }, 'concurrency' => { 'limit' => 1 }, 'dubbing_concurrency' => { 'limit' => 1 }, 'music_concurrency' => { 'limit' => 1 } }, 'expires_at_unix' => 1 }], 'default_sharing_groups' => [{ 'group' => { 'name' => 'test-value', 'id' => 'test-value', 'members' => ['test-value'], 'permissions' => ['text_to_speech'], 'group_usage_limit' => 1, 'group_pvc_limit' => 1, 'group_concurrency_limit' => 1, 'group_dubbing_concurrency_limit' => 1, 'group_music_concurrency_limit' => 1, 'character_count' => 1, 'is_scim_synced' => true, 'scim_group' => { 'scim_external_id' => 'test-value', 'display_name' => 'test-value', 'created_at_unix' => 1, 'updated_at_unix' => 1, 'seat_type' => 'workspace_admin' }, 'scim_frozen' => true }, 'permission_level' => 'admin' }] }] }

    instance = ::Elevenlabs::Types::WorkspaceServiceAccountListResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
