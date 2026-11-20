# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationProgressTest < Minitest::Test
  def test_round_trip
    wire = { 'scheduled' => 1, 'scheduled_by_type' => { 'key' => 1 }, 'awaiting_permission' => 1, 'in_progress' => 1, 'awaiting_analysis' => 1 }

    instance = ::Elevenlabs::Types::ConversationProgress.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
