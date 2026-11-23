# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationInitiationMetadataTest < Minitest::Test
  def test_round_trip
    wire = { 'conversation_initiation_metadata_event' => { 'conversation_id' => 'test-value', 'agent_output_audio_format' => 'pcm_8000', 'user_input_audio_format' => 'pcm_8000' }, 'type' => 'conversation_initiation_metadata' }

    instance = ::Elevenlabs::Types::ConversationInitiationMetadata.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
