# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BytedanceSeedance2RequestTest < Minitest::Test
  def test_round_trip
    wire = { 'webhook' => { 'type' => 'all' }, 'prompt' => 'test-value', 'aspect_ratio' => 'auto', 'duration_secs' => 4, 'seed' => 1, 'generate_audio' => true, 'start_frame' => { 'type' => 'generation', 'generation_id' => 'test-value' }, 'end_frame' => { 'type' => 'generation', 'generation_id' => 'test-value' }, 'images' => [{ 'type' => 'generation', 'generation_id' => 'test-value' }], 'videos' => [{ 'type' => 'generation', 'generation_id' => 'test-value' }], 'audios' => [{ 'type' => 'generation', 'generation_id' => 'test-value' }], 'model_id' => 'bytedance-seedance-v2', 'resolution' => '480p' }

    instance = ::Elevenlabs::Types::BytedanceSeedance2Request.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
