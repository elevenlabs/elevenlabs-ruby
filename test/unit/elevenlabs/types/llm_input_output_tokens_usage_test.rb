# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class LlmInputOutputTokensUsageTest < Minitest::Test
  def test_round_trip
    wire = { 'input' => { 'tokens' => 1, 'price' => 1 }, 'input_cache_read' => { 'tokens' => 1, 'price' => 1 }, 'input_cache_write' => { 'tokens' => 1, 'price' => 1 }, 'output_total' => { 'tokens' => 1, 'price' => 1 } }

    instance = ::Elevenlabs::Types::LlmInputOutputTokensUsage.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
