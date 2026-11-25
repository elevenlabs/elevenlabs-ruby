# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class LlmUsageOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'model_usage' => { 'key' => { 'input' => { 'tokens' => 1, 'price' => 1 }, 'input_cache_read' => { 'tokens' => 1, 'price' => 1 }, 'input_cache_write' => { 'tokens' => 1, 'price' => 1 }, 'output_total' => { 'tokens' => 1, 'price' => 1 }, 'output_total_reasoning_portion' => { 'tokens' => 1, 'price' => 1 } } } }

    instance = ::Elevenlabs::Types::LlmUsageOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
