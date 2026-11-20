# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WorkspaceConfigResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'version' => 1, 'config' => { 'policy' => { 'timezone' => 'test-value', 'retry' => { 'retry_delay_seconds' => 1, 'max_short_retries' => 0, 'max_total_calls' => 1, 'max_callbacks' => 0, 'max_redirects' => 0, 'interval_placement' => 'start', 'rotate_step_seconds' => 1, 'max_consecutive_failures_per_number' => 1 }, 'calling_periods' => [{ 'weekdays' => [0], 'intervals' => [{ 'start' => 'test-value', 'end' => 'test-value' }] }], 'date_overrides' => [{ 'start_date' => 'test-value', 'end_date' => 'test-value', 'intervals' => [{ 'start' => 'test-value', 'end' => 'test-value' }], 'name' => 'test-value' }], 'data_collection' => { 'callback_time' => 'test-value', 'redirect_phone_number' => 'test-value', 'stop' => 'test-value', 'mappings' => { 'key' => 'test-value' } }, 'followup_context' => { 'call_type' => true, 'previous_conversation_id' => true, 'previous_summary' => true, 'previous_transcript' => true } }, 'agent_policies' => { 'key' => { 'timezone' => 'test-value', 'retry' => { 'retry_delay_seconds' => 1, 'max_short_retries' => 0, 'max_total_calls' => 1, 'max_callbacks' => 0, 'max_redirects' => 0, 'interval_placement' => 'start', 'rotate_step_seconds' => 1, 'max_consecutive_failures_per_number' => 1 }, 'calling_periods' => [{ 'weekdays' => [0], 'intervals' => [{ 'start' => 'test-value', 'end' => 'test-value' }] }], 'date_overrides' => [{ 'start_date' => 'test-value', 'end_date' => 'test-value', 'intervals' => [{ 'start' => 'test-value', 'end' => 'test-value' }], 'name' => 'test-value' }], 'data_collection' => { 'callback_time' => 'test-value', 'redirect_phone_number' => 'test-value', 'stop' => 'test-value', 'mappings' => { 'key' => 'test-value' } }, 'followup_context' => { 'call_type' => true, 'previous_conversation_id' => true, 'previous_summary' => true, 'previous_transcript' => true } } }, 'whatsapp_voice_policy' => { 'timezone' => 'test-value', 'retry' => { 'retry_delay_seconds' => 1, 'max_short_retries' => 0, 'max_total_calls' => 1, 'max_callbacks' => 0, 'max_redirects' => 0, 'interval_placement' => 'start', 'rotate_step_seconds' => 1, 'max_consecutive_failures_per_number' => 1 }, 'calling_periods' => [{ 'weekdays' => [0], 'intervals' => [{ 'start' => 'test-value', 'end' => 'test-value' }] }], 'date_overrides' => [{ 'start_date' => 'test-value', 'end_date' => 'test-value', 'intervals' => [{ 'start' => 'test-value', 'end' => 'test-value' }], 'name' => 'test-value' }], 'data_collection' => { 'callback_time' => 'test-value', 'redirect_phone_number' => 'test-value', 'stop' => 'test-value', 'mappings' => { 'key' => 'test-value' } }, 'followup_context' => { 'call_type' => true, 'previous_conversation_id' => true, 'previous_summary' => true, 'previous_transcript' => true } } } }

    instance = ::Elevenlabs::Types::WorkspaceConfigResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
