# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AudioIsolationHistoryItemResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'title' => 'test-value', 'created_at_unix' => 1, 'format' => 'test-value', 'duration_seconds' => 1, 'download_url' => 'test-value', 'icon_url' => 'test-value', 'source_video_url' => 'test-value', 'supports_video' => true, 'processing' => true, 'video_processing_failed' => true, 'preview_b64' => 'test-value' }

    instance = ::Elevenlabs::Types::AudioIsolationHistoryItemResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
