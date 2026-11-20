# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyMoveSegmentsBetweenSpeakersV1DubbingResourceDubbingIDMigrateSegmentsPostTest < Minitest::Test
  def test_round_trip
    wire = { 'segment_ids' => ['test-value'], 'speaker_id' => 'test-value' }

    instance = ::Elevenlabs::Types::BodyMoveSegmentsBetweenSpeakersV1DubbingResourceDubbingIDMigrateSegmentsPost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
