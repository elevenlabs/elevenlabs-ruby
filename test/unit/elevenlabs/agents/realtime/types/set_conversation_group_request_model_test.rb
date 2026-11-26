# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SetConversationGroupRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'conversation_group_id' => 'test-value' }

    instance = ::Elevenlabs::Agents::Realtime::Types::SetConversationGroupRequestModel.new(wire)

    assert_equal(wire, instance.to_h.except('conversation_id'))
  end
end
