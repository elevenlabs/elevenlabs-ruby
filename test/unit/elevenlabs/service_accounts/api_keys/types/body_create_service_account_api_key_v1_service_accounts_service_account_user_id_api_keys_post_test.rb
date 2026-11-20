# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyCreateServiceAccountApiKeyV1ServiceAccountsServiceAccountUserIdApiKeysPostTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'permissions' => ['text_to_speech'], 'character_limit' => 1, 'allowed_ips' => ['test-value'], 'third_party_disable_allowed' => true, 'tts_concurrency_limit' => 1, 'dubbing_concurrency_limit' => 1, 'music_concurrency_limit' => 1, 'expires_at_unix' => 1 }

    instance = ::Elevenlabs::ServiceAccounts::APIKeys::Types::BodyCreateServiceAccountApiKeyV1ServiceAccountsServiceAccountUserIdApiKeysPost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
