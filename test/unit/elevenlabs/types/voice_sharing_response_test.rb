# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class VoiceSharingResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'status' => 'enabled', 'history_item_sample_id' => 'test-value', 'date_unix' => 1, 'whitelisted_emails' => ['test-value'], 'public_owner_id' => 'test-value', 'original_voice_id' => 'test-value', 'financial_rewards_enabled' => true, 'free_users_allowed' => true, 'live_moderation_enabled' => true, 'rate' => 1, 'fiat_rate' => 1, 'notice_period' => 1, 'disable_at_unix' => 1, 'voice_mixing_allowed' => true, 'featured' => true, 'category' => 'generated', 'reader_app_enabled' => true, 'image_url' => 'test-value', 'ban_reason' => 'test-value', 'liked_by_count' => 1, 'cloned_by_count' => 1, 'name' => 'test-value', 'description' => 'test-value', 'labels' => { 'key' => 'test-value' }, 'review_status' => 'not_requested', 'review_message' => 'test-value', 'enabled_in_library' => true, 'instagram_username' => 'test-value', 'twitter_username' => 'test-value', 'youtube_username' => 'test-value', 'tiktok_username' => 'test-value', 'moderation_check' => { 'date_checked_unix' => 1, 'name_value' => 'test-value', 'name_check' => true, 'description_value' => 'test-value', 'description_check' => true, 'sample_ids' => ['test-value'], 'sample_checks' => [1], 'captcha_ids' => ['test-value'], 'captcha_checks' => [1] }, 'reader_restricted_on' => [{ 'resource_type' => 'read', 'resource_id' => 'test-value' }] }

    instance = ::Elevenlabs::Types::VoiceSharingResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
