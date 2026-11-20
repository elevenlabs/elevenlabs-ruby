# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ModerationStatusResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'is_in_probation' => true, 'enterprise_check_nogo_voice' => true, 'enterprise_check_block_nogo_voice' => true, 'never_live_moderate' => true, 'nogo_voice_similar_voice_upload_count' => 1, 'enterprise_background_moderation_enabled' => true, 'is_ivc_captcha_required' => true, 'safety_status' => 'appeal_approved', 'warning_status' => 'warning', 'on_watchlist' => true }

    instance = ::Elevenlabs::Types::ModerationStatusResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
