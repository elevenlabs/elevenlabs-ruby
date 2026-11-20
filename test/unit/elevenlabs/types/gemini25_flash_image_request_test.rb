# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class Gemini25FlashImageRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'webhook' => { 'type' => 'all' }, 'prompt' => 'test-value', 'model_id' => 'gemini-2.5-flash-image', 'images' => [{ 'type' => 'generation', 'generation_id' => 'test-value' }], 'aspect_ratio' => 'auto' }

    instance = ::Elevenlabs::Types::Gemini25FlashImageRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
