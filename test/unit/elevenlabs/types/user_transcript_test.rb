# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class UserTranscriptTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'user_transcript', 'event_id' => 1, 'user_transcript' => [{ 'role' => 'test-value', 'content' => 'test-value' }] }

    instance = ::Elevenlabs::Types::UserTranscript.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
