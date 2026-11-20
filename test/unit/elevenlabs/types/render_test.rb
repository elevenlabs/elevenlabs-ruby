# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class RenderTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'version' => 1, 'language' => 'test-value', 'type' => 'mp4', 'media_ref' => { 'src' => 'test-value', 'content_type' => 'test-value', 'bucket_name' => 'test-value', 'random_path_slug' => 'test-value', 'duration_secs' => 1, 'is_audio' => true, 'url' => 'test-value' }, 'status' => 'complete' }

    instance = ::Elevenlabs::Types::Render.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
