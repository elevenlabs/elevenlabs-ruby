# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WorkspaceAPIKeyListResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'api-keys' => [{ 'name' => 'test-value', 'hint' => 'test-value', 'key_id' => 'test-value', 'service_account_user_id' => 'test-value', 'created_at_unix' => 1, 'is_disabled' => true, 'permissions' => ['text_to_speech'], 'disable_reason' => 'trial_ended', 'character_limit' => 1, 'character_count' => 1, 'hashed_xi_api_key' => 'test-value', 'allowed_ips' => ['test-value'], 'third_party_disable_allowed' => true, 'platform_limits' => { 'credits' => { 'limit' => 1, 'usage' => 1 }, 'pvc' => { 'limit' => 1 }, 'concurrency' => { 'limit' => 1 }, 'dubbing_concurrency' => { 'limit' => 1 }, 'music_concurrency' => { 'limit' => 1 } }, 'expires_at_unix' => 1 }] }

    instance = ::Elevenlabs::Types::WorkspaceAPIKeyListResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
