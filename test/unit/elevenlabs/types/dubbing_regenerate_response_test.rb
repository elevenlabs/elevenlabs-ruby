# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class DubbingRegenerateResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'regenerated_segment_ids' => ['test-value'], 'regenerated_seconds' => 1, 'charged_seconds' => 1, 'free_regeneration_seconds_remaining' => 1 }

    instance = ::Elevenlabs::Types::DubbingRegenerateResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
