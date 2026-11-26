# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyUpdatePvcVoiceSampleV1VoicesPvcVoiceIDSamplesSampleIDPostTest < Minitest::Test
  def test_round_trip
    wire = { 'remove_background_noise' => true, 'selected_speaker_ids' => ['test-value'], 'trim_start_time' => 1, 'trim_end_time' => 1, 'file_name' => 'test-value' }

    instance = ::Elevenlabs::Voices::Pvc::Samples::Types::BodyUpdatePvcVoiceSampleV1VoicesPvcVoiceIDSamplesSampleIDPost.new(wire)

    assert_equal(wire, instance.to_h.except('voice_id', 'sample_id'))
  end
end
