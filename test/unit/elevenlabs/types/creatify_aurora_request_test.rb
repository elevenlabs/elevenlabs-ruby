# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CreatifyAuroraRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'webhook' => { 'type' => 'all' }, 'model_id' => 'creatify-aurora', 'image' => { 'type' => 'generation', 'generation_id' => 'test-value' }, 'audio' => { 'type' => 'generation', 'generation_id' => 'test-value' }, 'resolution' => '480p', 'guidance_scale' => 0, 'audio_guidance_scale' => 0 }

    instance = ::Elevenlabs::Types::CreatifyAuroraRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
