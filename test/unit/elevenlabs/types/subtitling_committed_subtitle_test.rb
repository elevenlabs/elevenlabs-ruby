# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SubtitlingCommittedSubtitleTest < Minitest::Test
  def test_round_trip
    wire = { 'message_type' => 'committed_subtitle', 'cue_index' => 1, 'lines' => ['test-value'], 'start_ms' => 1, 'end_ms' => 1 }

    instance = ::Elevenlabs::Types::SubtitlingCommittedSubtitle.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
