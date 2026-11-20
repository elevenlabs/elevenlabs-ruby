# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SafetyCommonModelOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'ivc' => { 'is_unsafe' => true, 'llm_reason' => 'test-value', 'safety_prompt_version' => 1, 'matched_rule_id' => ['sexual_minors'] }, 'non_ivc' => { 'is_unsafe' => true, 'llm_reason' => 'test-value', 'safety_prompt_version' => 1, 'matched_rule_id' => ['sexual_minors'] } }

    instance = ::Elevenlabs::Types::SafetyCommonModelOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
