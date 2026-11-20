# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyCreateANewVoiceFromVoicePreviewV1TextToVoicePostTest < Minitest::Test
  def test_round_trip
    wire = { 'voice_name' => 'test-value', 'voice_description' => 'test-valuetest-value', 'generated_voice_id' => 'test-value', 'labels' => { 'key' => 'test-value' }, 'played_not_selected_voice_ids' => ['test-value'] }

    instance = ::Elevenlabs::TextToVoice::Types::BodyCreateANewVoiceFromVoicePreviewV1TextToVoicePost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
