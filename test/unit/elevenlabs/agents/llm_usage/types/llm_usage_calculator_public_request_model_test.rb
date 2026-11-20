# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class LlmUsageCalculatorPublicRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'prompt_length' => 1, 'number_of_pages' => 1, 'rag_enabled' => true, 'service_tier' => 'standard' }

    instance = ::Elevenlabs::Agents::LlmUsage::Types::LlmUsageCalculatorPublicRequestModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
