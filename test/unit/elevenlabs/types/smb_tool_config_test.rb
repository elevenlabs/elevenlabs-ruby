# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SmbToolConfigTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'smb', 'name' => 'test-value', 'description' => 'test-value', 'response_timeout_secs' => 1, 'disable_interruptions' => true, 'interruption_mode' => 'allow', 'force_pre_tool_speech' => true, 'pre_tool_speech' => 'auto', 'assignments' => [{ 'source' => 'response', 'dynamic_variable' => 'test-value', 'value_path' => 'test-value', 'sanitize' => true, 'preserve_native_type' => true }], 'tool_call_sound' => 'typing', 'tool_call_sound_behavior' => 'auto', 'tool_error_handling_mode' => 'auto', 'human_description' => 'test-value', 'enabled' => true, 'params' => { 'smb_tool_type' => 'search_clients' } }

    instance = ::Elevenlabs::Types::SmbToolConfig.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
