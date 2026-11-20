# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class Gemini31FlashLiteImageRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'webhook' => { 'type' => 'all' }, 'prompt' => 'test-value', 'model_id' => 'gemini-3.1-flash-lite-image', 'images' => [{ 'type' => 'generation', 'generation_id' => 'test-value' }], 'aspect_ratio' => 'auto', 'resolution' => '1K' }

    instance = ::Elevenlabs::Types::Gemini31FlashLiteImageRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
