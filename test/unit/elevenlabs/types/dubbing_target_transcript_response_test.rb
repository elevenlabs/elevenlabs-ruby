# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class DubbingTargetTranscriptResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'source_language' => 'test-value', 'target_language' => 'test-value', 'segments' => [{ 'id' => 'test-value', 'speaker_id' => 'test-value', 'start_s' => 1, 'end_s' => 1, 'source_text' => 'test-value', 'translation' => 'test-value' }], 'revision' => 1 }

    instance = ::Elevenlabs::Types::DubbingTargetTranscriptResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
