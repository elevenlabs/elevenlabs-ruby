# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class LlmDeprecationInfoModelTest < Minitest::Test
  def test_round_trip
    wire = { 'llm' => 'gpt-4o-mini', 'is_deprecated' => true, 'is_in_warning_period' => true, 'is_in_fallback_period' => true, 'fallback_percentage' => 1, 'provider_deprecation_date' => 'test-value', 'replacement_model' => 'gpt-4o-mini', 'deprecation_config' => { 'warning_start_days' => 1, 'fallback_start_days' => 1, 'fallback_complete_days' => 1, 'fallback_start_percentage' => 1, 'fallback_complete_percentage' => 1 } }

    instance = ::Elevenlabs::Types::LlmDeprecationInfoModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
