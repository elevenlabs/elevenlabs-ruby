# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GptImage15RequestTest < Minitest::Test
  def test_round_trip
    wire = { 'webhook' => { 'type' => 'all' }, 'prompt' => 'test-value', 'images' => [{ 'type' => 'generation', 'generation_id' => 'test-value' }], 'mask' => { 'type' => 'generation', 'generation_id' => 'test-value' }, 'quality' => 'low', 'background' => 'transparent', 'aspect_ratio' => '1:1', 'model_id' => 'gpt-image-1.5' }

    instance = ::Elevenlabs::Types::GptImage15Request.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
