# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class LlmUsageCalculatorResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'llm_prices' => [{ 'llm' => 'gpt-4o-mini', 'price_per_minute' => 1, 'price_per_message' => 1 }] }

    instance = ::Elevenlabs::Types::LlmUsageCalculatorResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
