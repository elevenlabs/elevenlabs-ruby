# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SubtitleOrderItemRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'kind' => 'subtitles', 'media_ids' => ['test-value'], 'source_language' => 'test-value', 'destination_languages' => ['test-value'], 'cue_options' => { 'min_duration_ms' => 2000, 'max_duration_ms' => 4000, 'max_lines_per_cue' => 1, 'max_chars_per_line' => 16, 'max_chars_per_s' => 15, 'min_gap_between_cues_frames' => 0 }, 'sdh' => true, 'instructions' => 'test-value' }

    instance = ::Elevenlabs::Types::SubtitleOrderItemRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
