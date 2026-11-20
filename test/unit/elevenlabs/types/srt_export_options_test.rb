# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SrtExportOptionsTest < Minitest::Test
  def test_round_trip
    wire = { 'max_characters_per_line' => 1, 'include_speakers' => true, 'include_timestamps' => true, 'format' => 'srt', 'segment_on_silence_longer_than_s' => 1, 'max_segment_duration_s' => 1, 'max_segment_chars' => 1 }

    instance = ::Elevenlabs::Types::SrtExportOptions.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
