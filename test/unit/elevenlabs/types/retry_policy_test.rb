# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class RetryPolicyTest < Minitest::Test
  def test_round_trip
    wire = { 'retry_delay_seconds' => 1, 'max_short_retries' => 0, 'max_total_calls' => 1, 'max_callbacks' => 0, 'max_redirects' => 0, 'interval_placement' => 'start', 'rotate_step_seconds' => 1, 'max_consecutive_failures_per_number' => 1 }

    instance = ::Elevenlabs::Types::RetryPolicy.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
