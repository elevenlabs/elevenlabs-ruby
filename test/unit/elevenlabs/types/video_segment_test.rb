# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class VideoSegmentTest < Minitest::Test
  def test_round_trip
    wire = { 'start_ms' => 1, 'end_ms' => 1, 'description' => 'test-value', 'subjects' => ['test-value'], 'shot_type' => 'test-value', 'camera_movement' => 'test-value', 'transition_in' => 'test-value', 'has_speech' => true, 'has_music' => true, 'pacing' => 'test-value' }

    instance = ::Elevenlabs::Types::VideoSegment.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
