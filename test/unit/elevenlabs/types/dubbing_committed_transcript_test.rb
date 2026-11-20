# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class DubbingCommittedTranscriptTest < Minitest::Test
  def test_round_trip
    wire = { 'message_type' => 'committed_transcript', 'text' => 'test-value', 'segment_id' => 'test-value', 'start_s' => 0, 'end_s' => 0, 'speaker_id' => 'test-value' }

    instance = ::Elevenlabs::Types::DubbingCommittedTranscript.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
