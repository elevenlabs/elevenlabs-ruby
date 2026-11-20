# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BytedanceSeedream5LiteRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'webhook' => { 'type' => 'all' }, 'prompt' => 'test-value', 'images' => [{ 'type' => 'generation', 'generation_id' => 'test-value' }], 'aspect_ratio' => 'auto', 'seed' => 1, 'model_id' => 'bytedance-seedream-5-lite', 'resolution' => '2K' }

    instance = ::Elevenlabs::Types::BytedanceSeedream5LiteRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
