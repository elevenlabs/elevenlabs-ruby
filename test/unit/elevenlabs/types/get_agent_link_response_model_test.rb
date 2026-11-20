# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetAgentLinkResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'agent_id' => 'test-value', 'token' => { 'agent_id' => 'test-value', 'conversation_token' => 'test-value', 'expiration_time_unix_secs' => 1, 'conversation_id' => 'test-value', 'purpose' => 'signed_url', 'token_requester_user_id' => 'test-value' } }

    instance = ::Elevenlabs::Types::GetAgentLinkResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
