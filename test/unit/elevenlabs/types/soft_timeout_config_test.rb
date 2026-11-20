# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SoftTimeoutConfigTest < Minitest::Test
  def test_round_trip
    wire = { 'timeout_seconds' => 1, 'message' => 'test-value', 'additional_soft_timeout_messages' => ['test-value'], 'use_llm_generated_message' => true, 'randomize_fillers' => true, 'max_soft_timeouts_per_generation' => 1, 'llm_generated_message_prompt_override' => 'test-value', 'disable_until_first_user_message' => true }

    instance = ::Elevenlabs::Types::SoftTimeoutConfig.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
