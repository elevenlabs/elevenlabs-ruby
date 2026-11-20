# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PartialTranscriptTest < Minitest::Test
  def test_round_trip
    wire = { 'message_type' => 'partial_transcript', 'text' => 'test-value', 'turn_probability' => 1, 'language_code' => 'test-value', 'words' => [{ 'text' => 'test-value', 'start' => 1, 'end' => 1, 'type' => 'word', 'speaker_id' => 'test-value', 'logprob' => 1, 'characters' => [{ 'text' => 'test-value', 'start' => 1, 'end' => 1 }], 'channel_index' => 1 }] }

    instance = ::Elevenlabs::Types::PartialTranscript.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
