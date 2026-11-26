# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyAddSharedVoiceV1VoicesAddPublicUserIDVoiceIDPostTest < Minitest::Test
  def test_round_trip
    wire = { 'new_name' => 'test-value', 'bookmarked' => true }

    instance = ::Elevenlabs::Voices::Types::BodyAddSharedVoiceV1VoicesAddPublicUserIDVoiceIDPost.new(wire)

    assert_equal(wire, instance.to_h.except('public_user_id', 'voice_id'))
  end
end
