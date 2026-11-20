# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ListMcpToolsResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'success' => true, 'tools' => [{ 'name' => 'test-value', 'title' => 'test-value', 'description' => 'test-value', 'inputSchema' => {}, 'execution' => { 'taskSupport' => 'forbidden' }, 'outputSchema' => {}, 'icons' => [{ 'src' => 'test-value', 'mimeType' => 'test-value', 'sizes' => ['test-value'], 'theme' => 'light' }], 'annotations' => { 'title' => 'test-value', 'readOnlyHint' => true, 'destructiveHint' => true, 'idempotentHint' => true, 'openWorldHint' => true }, '_meta' => {} }], 'tool_approval_statuses' => [{ 'tool_id' => 'test-value', 'state' => 'up_to_date', 'approval_policy' => 'auto_approved', 'approved_definition' => { 'description' => 'test-value', 'input_schema' => {} } }], 'error_message' => 'test-value' }

    instance = ::Elevenlabs::Types::ListMcpToolsResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
