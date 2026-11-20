# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ModerationGuardrailInputTest < Minitest::Test
  def test_round_trip
    wire = { 'execution_mode' => 'streaming', 'config' => { 'sexual' => { 'is_enabled' => true, 'threshold' => 0 }, 'violence' => { 'is_enabled' => true, 'threshold' => 0 }, 'violence_graphic' => { 'is_enabled' => true, 'threshold' => 0 }, 'harassment' => { 'is_enabled' => true, 'threshold' => 0 }, 'harassment_threatening' => { 'is_enabled' => true, 'threshold' => 0 }, 'hate' => { 'is_enabled' => true, 'threshold' => 0 }, 'hate_threatening' => { 'is_enabled' => true, 'threshold' => 0 }, 'self_harm_instructions' => { 'is_enabled' => true, 'threshold' => 0 }, 'self_harm' => { 'is_enabled' => true, 'threshold' => 0 }, 'self_harm_intent' => { 'is_enabled' => true, 'threshold' => 0 }, 'sexual_minors' => { 'is_enabled' => true, 'threshold' => 0 } } }

    instance = ::Elevenlabs::Types::ModerationGuardrailInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
