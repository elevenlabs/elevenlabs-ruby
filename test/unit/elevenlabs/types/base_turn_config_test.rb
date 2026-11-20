# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BaseTurnConfigTest < Minitest::Test
  def test_round_trip
    wire = { 'turn_timeout' => 1, 'initial_wait_time' => 1, 'silence_end_call_timeout' => 1, 'turn_eagerness' => 'patient', 'spelling_patience' => 'auto', 'speculative_turn' => true, 'retranscribe_on_turn_timeout' => true, 'turn_model' => 'turn_v2', 'interruption_ignore_terms' => ['test-value'], 'interruption_ignore_term_languages' => ['test-value'], 'merge_with_default_ignore_terms' => true, 'transcribe_on_disabled_interruptions' => true }

    instance = ::Elevenlabs::Types::BaseTurnConfig.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
