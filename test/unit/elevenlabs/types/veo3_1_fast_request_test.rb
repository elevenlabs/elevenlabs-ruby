# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class Veo31FastRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'webhook' => { 'type' => 'all' }, 'prompt' => 'test-value', 'negative_prompt' => 'test-value', 'seed' => 1, 'enhance_prompt' => true, 'duration_secs' => 4, 'aspect_ratio' => '16:9', 'resolution' => '720p', 'generate_audio' => true, 'start_frame' => { 'type' => 'generation', 'generation_id' => 'test-value' }, 'end_frame' => { 'type' => 'generation', 'generation_id' => 'test-value' }, 'images' => [{ 'image' => { 'type' => 'generation', 'generation_id' => 'test-value' }, 'role' => 'subject' }], 'model_id' => 'veo-3.1-fast-generate-001' }

    instance = ::Elevenlabs::Types::Veo31FastRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
