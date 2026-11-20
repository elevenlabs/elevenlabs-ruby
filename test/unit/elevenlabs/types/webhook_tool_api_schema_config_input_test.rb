# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WebhookToolAPISchemaConfigInputTest < Minitest::Test
  def test_round_trip
    wire = { 'request_headers' => { 'key' => 'test-value' }, 'url' => 'test-value', 'method' => 'GET', 'path_params_schema' => { 'key' => { 'type' => 'boolean', 'description' => 'test-value', 'enum' => ['test-value'], 'is_system_provided' => true, 'dynamic_variable' => 'test-value', 'allowed_values' => { 'dynamic_variable' => 'test-value' }, 'allowed_values_dynamic_variable' => 'test-value', 'constant_value' => 'test-value', 'is_omitted' => true } }, 'query_params_schema' => { 'properties' => { 'key' => { 'type' => 'boolean', 'description' => 'test-value', 'enum' => ['test-value'], 'is_system_provided' => true, 'dynamic_variable' => 'test-value', 'allowed_values' => { 'dynamic_variable' => 'test-value' }, 'allowed_values_dynamic_variable' => 'test-value', 'constant_value' => 'test-value', 'is_omitted' => true } }, 'required' => ['test-value'] }, 'request_body_schema' => { 'property_kind' => 'array', 'description' => 'test-value', 'dynamic_variable' => 'test-value', 'constant_value' => {}, 'is_omitted' => true, 'type' => 'object', 'required' => ['test-value'], 'properties' => { 'key' => { 'type' => 'boolean', 'description' => 'test-value', 'enum' => ['test-value'], 'is_system_provided' => true, 'dynamic_variable' => 'test-value', 'allowed_values' => { 'dynamic_variable' => 'test-value' }, 'allowed_values_dynamic_variable' => 'test-value', 'constant_value' => 'test-value', 'is_omitted' => true } }, 'required_constraints' => { 'any_of' => [{ 'required' => ['test-value'] }], 'all_of' => [{ 'required' => ['test-value'] }] } }, 'response_body_schema' => { 'property_kind' => 'array', 'description' => 'test-value', 'dynamic_variable' => 'test-value', 'constant_value' => {}, 'is_omitted' => true, 'type' => 'object', 'required' => ['test-value'], 'properties' => { 'key' => { 'type' => 'boolean', 'description' => 'test-value', 'enum' => ['test-value'], 'is_system_provided' => true, 'dynamic_variable' => 'test-value', 'allowed_values' => { 'dynamic_variable' => 'test-value' }, 'allowed_values_dynamic_variable' => 'test-value', 'constant_value' => 'test-value', 'is_omitted' => true } }, 'required_constraints' => { 'any_of' => [{ 'required' => ['test-value'] }], 'all_of' => [{ 'required' => ['test-value'] }] } }, 'response_filter' => { 'mode' => 'all', 'filters' => ['test-value'], 'content_type' => 'application/json' }, 'content_type' => 'application/json', 'auth_resolved_params' => ['test-value'], 'auth_connection' => { 'auth_connection_id' => 'test-value' } }

    instance = ::Elevenlabs::Types::WebhookToolAPISchemaConfigInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
