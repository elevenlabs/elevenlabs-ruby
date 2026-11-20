# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PrivacyConfigOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'record_voice' => true, 'retention_days' => 1, 'delete_transcript_and_pii' => true, 'delete_audio' => true, 'apply_to_existing_conversations' => true, 'zero_retention_mode' => true, 'conversation_history_redaction' => { 'enabled' => true, 'entities' => ['name'], 'excluded_data_collection_ids' => ['test-value'] } }

    instance = ::Elevenlabs::Types::PrivacyConfigOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
