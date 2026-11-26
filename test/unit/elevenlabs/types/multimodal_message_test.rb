# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class MultimodalMessageTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'multimodal_message', 'text' => { 'id' => 'test-value', 'type' => 'user_message', 'text' => 'test-value', 'user_identifier' => 'test-value', 'source_medium' => 'audio' }, 'file' => { 'type' => 'file_input', 'file_id' => 'test-value' }, 'files' => [{ 'type' => 'file_input', 'file_id' => 'test-value' }] }

    instance = ::Elevenlabs::Types::MultimodalMessage.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
