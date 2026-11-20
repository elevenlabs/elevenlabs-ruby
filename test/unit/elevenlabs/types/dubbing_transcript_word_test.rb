# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class DubbingTranscriptWordTest < Minitest::Test
  def test_round_trip
    wire = { 'text' => 'test-value', 'word_type' => 'test-value', 'start_s' => 1, 'end_s' => 1, 'characters' => [{ 'text' => 'test-value', 'start_s' => 1, 'end_s' => 1 }] }

    instance = ::Elevenlabs::Types::DubbingTranscriptWord.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
