# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class DubbingMetadataResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'dubbing_id' => 'test-value', 'name' => 'test-value', 'status' => 'test-value', 'source_language' => 'test-value', 'target_languages' => ['test-value'], 'editable' => true, 'created_at' => 'test-value', 'media_metadata' => { 'content_type' => 'test-value', 'duration' => 1 }, 'error' => 'test-value' }

    instance = ::Elevenlabs::Types::DubbingMetadataResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
