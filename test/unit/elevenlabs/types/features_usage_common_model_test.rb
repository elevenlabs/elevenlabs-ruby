# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class FeaturesUsageCommonModelTest < Minitest::Test
  def test_round_trip
    wire = { 'language_detection' => { 'enabled' => true, 'used' => true }, 'transfer_to_agent' => { 'enabled' => true, 'used' => true }, 'transfer_to_number' => { 'enabled' => true, 'used' => true }, 'multivoice' => { 'enabled' => true, 'used' => true }, 'dtmf_tones' => { 'enabled' => true, 'used' => true }, 'external_mcp_servers' => { 'enabled' => true, 'used' => true }, 'pii_zrm_workspace' => true, 'pii_zrm_agent' => true, 'tool_dynamic_variable_updates' => { 'enabled' => true, 'used' => true }, 'is_livekit' => true, 'voicemail_detection' => { 'enabled' => true, 'used' => true }, 'dtmf_input' => { 'enabled' => true, 'used' => true }, 'workflow' => { 'enabled' => true, 'tool_node' => { 'enabled' => true, 'used' => true }, 'standalone_agent_node' => { 'enabled' => true, 'used' => true }, 'phone_number_node' => { 'enabled' => true, 'used' => true }, 'end_node' => { 'enabled' => true, 'used' => true }, 'override_agent_node' => { 'enabled' => true, 'used' => true } }, 'agent_testing' => { 'enabled' => true, 'tests_ran_after_last_modification' => true, 'tests_ran_in_last_7_days' => true }, 'versioning' => { 'enabled' => true, 'used' => true }, 'file_input' => { 'enabled' => true, 'used' => true }, 'freeform_procedure' => { 'enabled' => true, 'used' => true }, 'structured_procedure' => { 'enabled' => true, 'used' => true } }

    instance = ::Elevenlabs::Types::FeaturesUsageCommonModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
