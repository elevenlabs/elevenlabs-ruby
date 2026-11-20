# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class VideoAnalysisResultTest < Minitest::Test
  def test_round_trip
    wire = { 'title' => 'test-value', 'description' => 'test-value', 'content_type' => 'test-value', 'overall_pacing' => 'test-value', 'subjects' => [{ 'name' => 'test-value', 'description' => 'test-value' }], 'segments' => [{ 'start_ms' => 1, 'end_ms' => 1, 'description' => 'test-value', 'subjects' => ['test-value'], 'shot_type' => 'test-value', 'camera_movement' => 'test-value', 'transition_in' => 'test-value', 'has_speech' => true, 'has_music' => true, 'pacing' => 'test-value' }], 'key_moments' => [{ 'timestamp_ms' => 1, 'type' => 'test-value', 'description' => 'test-value' }] }

    instance = ::Elevenlabs::Types::VideoAnalysisResult.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
