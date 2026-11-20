# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SpeakerSeparationResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'voice_id' => 'test-value', 'sample_id' => 'test-value', 'status' => 'not_started', 'speakers' => { 'key' => { 'speaker_id' => 'test-value', 'duration_secs' => 1, 'utterances' => [{ 'start' => 1, 'end' => 1 }] } }, 'selected_speaker_ids' => ['test-value'] }

    instance = ::Elevenlabs::Types::SpeakerSeparationResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
