# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class HTMLExportOptionsTest < Minitest::Test
  def test_round_trip
    wire = { 'include_speakers' => true, 'include_timestamps' => true, 'format' => 'html', 'segment_on_silence_longer_than_s' => 1, 'max_segment_duration_s' => 1, 'max_segment_chars' => 1 }

    instance = ::Elevenlabs::Types::HTMLExportOptions.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
