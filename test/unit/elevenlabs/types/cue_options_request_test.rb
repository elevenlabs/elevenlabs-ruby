# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CueOptionsRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'min_duration_ms' => 2000, 'max_duration_ms' => 4000, 'max_lines_per_cue' => 1, 'max_chars_per_line' => 16, 'max_chars_per_s' => 15, 'min_gap_between_cues_frames' => 0 }

    instance = ::Elevenlabs::Types::CueOptionsRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
