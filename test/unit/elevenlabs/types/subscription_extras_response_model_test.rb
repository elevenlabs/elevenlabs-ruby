# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SubscriptionExtrasResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'concurrency' => 1, 'convai_concurrency' => 1, 'enterprise_music_concurrency' => 1, 'music_finetunes_total_limit' => 1, 'music_finetunes_monthly_limit' => 1, 'music_finetunes_concurrency_limit' => 1, 'convai_chars_per_minute' => 1, 'convai_asr_chars_per_minute' => 1, 'force_logging_disabled' => true, 'can_request_manual_pro_voice_verification' => true, 'can_bypass_voice_captcha' => true, 'moderation' => { 'is_in_probation' => true, 'enterprise_check_nogo_voice' => true, 'enterprise_check_block_nogo_voice' => true, 'never_live_moderate' => true, 'nogo_voice_similar_voice_upload_count' => 1, 'enterprise_background_moderation_enabled' => true, 'is_ivc_captcha_required' => true, 'safety_status' => 'appeal_approved', 'warning_status' => 'warning', 'on_watchlist' => true }, 'unused_characters_rolled_over_from_previous_period' => 1, 'overused_characters_rolled_over_from_previous_period' => 1, 'usage' => { 'rollover_credits_quota' => 1, 'subscription_cycle_credits_quota' => 1, 'manually_gifted_credits_quota' => 1, 'payg_credits_quota' => 1, 'rollover_credits_used' => 1, 'subscription_cycle_credits_used' => 1, 'manually_gifted_credits_used' => 1, 'payg_credits_used' => 1, 'paid_usage_based_credits_used' => 1, 'actual_reported_credits' => 1 } }

    instance = ::Elevenlabs::Types::SubscriptionExtrasResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
