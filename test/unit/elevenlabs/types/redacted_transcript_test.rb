# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class RedactedTranscriptTest < Minitest::Test
  def test_round_trip
    wire = { 'message_type' => 'redacted_transcript', 'text' => 'test-value', 'redacted_text' => 'test-value' }

    instance = ::Elevenlabs::Types::RedactedTranscript.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
