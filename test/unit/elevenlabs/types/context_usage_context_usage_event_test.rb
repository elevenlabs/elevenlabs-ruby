# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ContextUsageContextUsageEventTest < Minitest::Test
  def test_round_trip
    wire = { 'event_id' => 1, 'model' => 'test-value', 'context_tokens' => 1, 'context_limit_tokens' => 1 }

    instance = ::Elevenlabs::Types::ContextUsageContextUsageEvent.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
