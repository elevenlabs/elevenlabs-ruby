# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ContentGuardrailInputTest < Minitest::Test
  def test_round_trip
    wire = { 'execution_mode' => 'streaming', 'config' => { 'sexual' => { 'is_enabled' => true, 'threshold' => 1 }, 'violence' => { 'is_enabled' => true, 'threshold' => 1 }, 'harassment' => { 'is_enabled' => true, 'threshold' => 1 }, 'self_harm' => { 'is_enabled' => true, 'threshold' => 1 }, 'profanity' => { 'is_enabled' => true, 'threshold' => 1 }, 'religion_or_politics' => { 'is_enabled' => true, 'threshold' => 1 }, 'medical_and_legal_information' => { 'is_enabled' => true, 'threshold' => 1 } }, 'trigger_action' => { 'type' => 'end_call' } }

    instance = ::Elevenlabs::Types::ContentGuardrailInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
