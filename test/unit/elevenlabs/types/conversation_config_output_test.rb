# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationConfigOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'text_only' => true, 'max_duration_seconds' => 1, 'client_events' => ['conversation_initiation_metadata'], 'file_input' => { 'enabled' => true, 'max_files_in_memory' => 1, 'max_files_per_conversation' => 1 }, 'monitoring_enabled' => true, 'monitoring_events' => ['conversation_initiation_metadata'], 'dtmf_input_settings' => { 'dtmf_input_timeout' => 0.5, 'hash_terminator' => true, 'redact_input' => true }, 'background_sound' => { 'source_type' => 'preset', 'source_id' => 'office2', 'volume' => 0.01, 'crossfade_loop' => true }, 'source_attribution' => true }

    instance = ::Elevenlabs::Types::ConversationConfigOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
