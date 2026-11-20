# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AttentionViewTest < Minitest::Test
  def test_round_trip
    wire = { 'attention_id' => 'test-value', 'campaign_id' => 'test-value', 'reason' => 'test-value', 'detail' => 'test-value', 'status' => 'open', 'retryable' => true, 'resolution' => 'test-value', 'created_at_unix' => 1, 'updated_at_unix' => 1 }

    instance = ::Elevenlabs::Types::AttentionView.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
