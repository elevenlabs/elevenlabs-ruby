# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BytedanceSeedance25RequestTest < Minitest::Test
  def test_round_trip
    wire = { 'webhook' => { 'type' => 'all' }, 'model_id' => 'bytedance-seedance-v2.5', 'prompt' => 'test-value', 'aspect_ratio' => 'auto', 'resolution' => '480p', 'duration_secs' => 4, 'generate_audio' => true, 'start_frame' => { 'type' => 'generation', 'generation_id' => 'test-value' }, 'end_frame' => { 'type' => 'generation', 'generation_id' => 'test-value' }, 'images' => [{ 'type' => 'generation', 'generation_id' => 'test-value' }], 'videos' => [{ 'type' => 'generation', 'generation_id' => 'test-value' }], 'audios' => [{ 'type' => 'generation', 'generation_id' => 'test-value' }] }

    instance = ::Elevenlabs::Types::BytedanceSeedance25Request.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
