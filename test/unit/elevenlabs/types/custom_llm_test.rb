# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CustomLlmTest < Minitest::Test
  def test_round_trip
    wire = { 'url' => 'test-value', 'model_id' => 'test-value', 'api_key' => { 'secret_id' => 'test-value' }, 'auth_connection' => { 'auth_connection_id' => 'test-value' }, 'request_headers' => { 'key' => 'test-value' }, 'api_version' => 'test-value', 'api_type' => 'chat_completions' }

    instance = ::Elevenlabs::Types::CustomLlm.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
