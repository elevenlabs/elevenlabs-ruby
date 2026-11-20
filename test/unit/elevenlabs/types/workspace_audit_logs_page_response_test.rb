# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WorkspaceAuditLogsPageResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'entries' => [{ 'metadata' => {}, 'time' => 1, 'activity_id' => 0, 'activity_name' => 'test-value', 'category_name' => 'test-value', 'category_uid' => 1, 'class_name' => 'test-value', 'class_uid' => 1, 'severity_id' => 0, 'status_id' => 0, 'actor' => { 'user' => { 'name' => 'test-value', 'uid' => 'test-value', 'type_id' => 0, 'type' => 'test-value', 'email_addr' => 'test-value', 'full_name' => 'test-value', 'domain' => 'test-value' }, 'app_name' => 'test-value', 'app_uid' => 'test-value', 'session' => {} }, 'device' => { 'ip' => 'test-value', 'hostname' => 'test-value', 'type_id' => 1 }, 'http_request' => { 'http_method' => 'test-value', 'url' => { 'url_string' => 'test-value', 'scheme' => 'test-value', 'hostname' => 'test-value', 'port' => 1, 'path' => 'test-value', 'query_string' => 'test-value' }, 'user_agent' => 'test-value', 'x_forwarded_for' => ['test-value'] }, 'message' => 'test-value', 'unmapped' => {}, 'id' => 'test-value', 'time_dt' => 'test-value', 'type_uid' => 1, 'type_name' => 'test-value' }], 'has_more' => true, 'next_cursor' => 'test-value' }

    instance = ::Elevenlabs::Types::WorkspaceAuditLogsPageResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
