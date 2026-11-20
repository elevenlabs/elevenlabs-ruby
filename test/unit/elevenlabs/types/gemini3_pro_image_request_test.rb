# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class Gemini3ProImageRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'webhook' => { 'type' => 'all' }, 'prompt' => 'test-value', 'model_id' => 'gemini-3-pro-image', 'images' => [{ 'type' => 'generation', 'generation_id' => 'test-value' }], 'aspect_ratio' => 'auto', 'resolution' => '1K' }

    instance = ::Elevenlabs::Types::Gemini3ProImageRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
