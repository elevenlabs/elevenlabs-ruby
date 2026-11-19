# frozen_string_literal: true

require_relative 'support'

module Elevenlabs
  module AgentTools
    # Rules shared by every port of the tool builder, beyond what the shared fixtures cover.
    class ReviewRegressionsTest < Minitest::Test
      include Support

      def webhook(api_schema, config = {})
        Tool.from_json({ 'type' => 'webhook', 'name' => 't', 'description' => 'T',
                         'api_schema' => { 'method' => 'GET', 'url' => 'https://api.example.com/t' }.merge(api_schema) }
                         .merge(config))
      end

      def client(parameters)
        Tool.from_json('type' => 'client', 'name' => 't', 'description' => 'T', 'parameters' => parameters)
      end

      def nullable(constant)
        { 'type' => 'object', 'required' => ['x'],
          'properties' => { 'x' => { 'type' => %w[integer null], 'constant_value' => constant } } }
      end

      # Rule 1: removing the last entry leaves the field out.

      def test_removing_the_last_assignment_leaves_assignments_out
        refute get_order.assign('a', 'a').remove_assignment('a').to_json.key?('assignments')
      end

      def test_a_loaded_empty_assignments_list_round_trips
        assert_equal [], webhook({}, { 'assignments' => [] }).to_json['assignments']
      end

      def test_removing_a_missing_assignment_from_a_loaded_empty_list_changes_nothing
        assert_equal [], webhook({}, { 'assignments' => [] }).as_webhook.remove_assignment('a').to_json['assignments']
      end

      def test_removing_the_last_client_param_leaves_parameters_out
        tool = Tool.client('show', 'Show').param('a', Schema.string.describe('A')).remove_param('a')

        refute tool.to_json.key?('parameters')
      end

      def test_a_loaded_empty_parameters_schema_is_written_as_an_object
        assert_equal({ 'type' => 'object' }, client({}).to_json['parameters'])
      end

      def test_removing_a_missing_client_param_changes_nothing
        assert_equal({ 'type' => 'object' }, client({}).as_client.remove_param('a').to_json['parameters'])
      end

      # Rule 2: an empty URL counts as missing.

      def test_an_empty_url_is_missing
        assert_equal(['missing_url'], codes_of { Tool.webhook('t', 'T').get('').build })
      end

      def test_a_loaded_empty_url_is_missing
        assert_equal(['missing_url'], codes_of { webhook('url' => '').build })
      end

      # Rule 3: a loaded schema with a declared type that isn't an object is kept and reported.

      def test_a_loaded_body_that_is_not_an_object_is_reported
        tool = webhook('method' => 'POST', 'request_body_schema' => { 'type' => 'string', 'description' => 'X' })

        assert_equal([%w[body_not_object body]], codes_and_paths_of { tool.build })
      end

      def test_a_loaded_response_that_is_not_an_object_is_reported
        tool = webhook('response_body_schema' => { 'type' => 'string', 'description' => 'X' })

        assert_equal([%w[body_not_object response]], codes_and_paths_of { tool.build })
      end

      def test_loaded_client_params_that_are_not_an_object_are_reported
        tool = client('type' => 'string', 'description' => 'X')
        tool.param('y', Schema.string.describe('Y'))

        assert_equal([%w[body_not_object params]], codes_and_paths_of { tool.build })
      end

      def test_a_loaded_query_that_is_not_an_object_is_reported
        tool = webhook('query_params_schema' => { 'type' => 'string', 'description' => 'X' }).as_webhook
        tool.query_param('y', Schema.string.describe('Y')).remove_query_param('y')

        assert_equal([%w[body_not_object query]], codes_and_paths_of { tool.build })
      end

      def test_a_loaded_empty_body_is_written_as_an_object
        assert_equal({ 'type' => 'object' }, webhook('method' => 'POST', 'request_body_schema' => {}).to_json['api_schema']['request_body_schema'])
      end

      # Rule 4: a null constant on a nullable literal survives loading and building.

      def test_a_null_constant_on_a_nullable_literal_round_trips
        assert_equal nullable(nil), client(nullable(nil)).to_json['parameters']
      end

      def test_a_null_constant_on_a_nullable_literal_reaches_the_built_request
        built = ::JSON.parse(::JSON.generate(client(nullable(nil)).build.to_h))

        assert_equal nullable(nil), ToolWire.canonical(built['tool_config']['parameters'])
      end

      def test_a_null_constant_on_a_literal_that_is_not_nullable_is_unset
        tool = client('type' => 'object',
                      'properties' => { 'x' => { 'type' => 'string', 'description' => 'X', 'constant_value' => nil } })

        assert_equal({ 'description' => 'X', 'type' => 'string' }, tool.to_json['parameters']['properties']['x'])
      end

      def test_a_loaded_typeless_params_schema_is_written_as_an_object_after_edits
        tool = client('properties' => { 'a' => { 'type' => 'string', 'description' => 'A' } }).as_client
        tool.param('b', Schema.string.describe('B'))

        assert_equal 'object', tool.to_json['parameters']['type']
      end

      def test_a_loaded_typeless_response_is_written_as_an_object
        tool = webhook('response_body_schema' => { 'properties' => { 's' => { 'type' => 'string', 'description' => 'S' } } })

        assert_equal 'object', tool.to_json['api_schema']['response_body_schema']['type']
      end

      def test_a_loaded_typeless_query_gets_no_type
        tool = webhook('query_params_schema' => { 'properties' => { 'q' => { 'type' => 'string', 'description' => 'Q' } } })
        tool.as_webhook.query_param('r', Schema.string.describe('R'))

        refute tool.to_json['api_schema']['query_params_schema'].key?('type')
      end

      def test_a_loaded_query_type_is_kept
        query = { 'type' => 'object', 'properties' => { 'q' => { 'type' => 'string', 'description' => 'Q' } } }

        assert_equal 'object', webhook('query_params_schema' => query).to_json['api_schema']['query_params_schema']['type']
      end

      # Rule 5: a loaded query_params_schema keeps every loaded field.

      def test_a_loaded_query_keeps_fields_the_builder_does_not_model
        query = { 'future_field' => 1, 'properties' => { 'q' => { 'type' => 'string', 'description' => 'Q' } },
                  'required' => ['q'] }

        assert_equal query, webhook('query_params_schema' => query).to_json['api_schema']['query_params_schema']
      end

      def test_a_loaded_query_with_extra_fields_and_no_properties_is_kept
        assert_equal({ 'future_field' => 1 },
                     webhook('query_params_schema' => { 'future_field' => 1 }).to_json['api_schema']['query_params_schema'])
      end

      def test_a_query_built_by_the_builder_has_no_type
        tool = Tool.webhook('t', 'T').get('https://api.example.com/t').query_param('q', Schema.string.describe('Q'))

        refute tool.to_json['api_schema']['query_params_schema'].key?('type')
      end

      def test_removing_the_last_built_query_param_leaves_the_query_out
        tool = Tool.webhook('t', 'T').get('https://api.example.com/t')
                   .query_param('q', Schema.string.describe('Q')).remove_query_param('q')

        refute tool.to_json['api_schema'].key?('query_params_schema')
      end

      # Rule 6: loaded allowed_values and required_constraints keep the fields the builder doesn't model.

      def params_of(parameters)
        client(parameters).to_json['parameters']
      end

      def test_a_loaded_allowed_values_object_keeps_unmodeled_fields
        parameters = { 'type' => 'object', 'required' => ['x'],
                       'properties' => { 'x' => { 'type' => 'string', 'description' => 'X',
                                                  'allowed_values' => { 'dynamic_variable' => 'ids',
                                                                        'future_field' => 1 } } } }

        assert_equal parameters, params_of(parameters)
      end

      def test_allowed_from_on_a_loaded_schema_overlays_the_variable_name
        loaded = Schema.from_json('type' => 'string', 'description' => 'X',
                                  'allowed_values' => { 'dynamic_variable' => 'ids', 'future_field' => 1 })

        assert_equal({ 'dynamic_variable' => 'other', 'future_field' => 1 },
                     loaded.allowed_from('other').to_json['allowed_values'])
      end

      def test_a_loaded_required_constraints_object_keeps_unmodeled_fields
        parameters = { 'type' => 'object',
                       'properties' => { 'a' => { 'type' => 'string', 'description' => 'A' },
                                         'b' => { 'type' => 'string', 'description' => 'B' } },
                       'required_constraints' => { 'all_of' => [{ 'required' => ['b'] }],
                                                   'any_of' => [{ 'group_field' => true, 'required' => ['a'] }],
                                                   'future_field' => 1 } }

        assert_equal parameters, params_of(parameters)
      end

      def test_a_loaded_empty_required_constraints_round_trips
        parameters = { 'type' => 'object', 'properties' => { 'a' => { 'type' => 'string', 'description' => 'A' } },
                       'required_constraints' => { 'all_of' => [], 'any_of' => [] } }

        assert_equal parameters, params_of(parameters)
      end

      def test_require_any_of_on_a_loaded_schema_appends_to_the_loaded_groups
        loaded = Schema.from_json('type' => 'object',
                                  'properties' => { 'a' => { 'type' => 'string', 'description' => 'A' },
                                                    'b' => { 'type' => 'string', 'description' => 'B' } },
                                  'required_constraints' => { 'any_of' => [{ 'group_field' => true, 'required' => ['a'] }],
                                                              'future_field' => 1 })

        assert_equal({ 'any_of' => [{ 'group_field' => true, 'required' => ['a'] }, { 'required' => ['b'] }],
                       'future_field' => 1 },
                     loaded.require_any_of(['b']).to_json['required_constraints'])
      end

      def test_allowed_values_and_required_constraints_on_other_kinds_are_kept
        parameters = { 'type' => 'object', 'required' => ['x'],
                       'properties' => { 'x' => { 'type' => 'string', 'description' => 'X',
                                                  'required_constraints' => { 'any_of' => [] } } },
                       'allowed_values' => { 'dynamic_variable' => 'ids' } }

        assert_equal parameters, params_of(parameters)
      end

      def test_a_loaded_constraint_naming_a_missing_property_is_reported
        tool = client('type' => 'object', 'properties' => { 'a' => { 'type' => 'string', 'description' => 'A' } },
                      'required_constraints' => { 'any_of' => [{ 'required' => ['z'] }] })

        assert_equal([%w[unknown_required_property params]], codes_and_paths_of { tool.build })
      end

      # Rule 7: to_json_string writes numbers the way JavaScript's Number.prototype.toString does.

      def written_constant(value)
        tool = Tool.client('show', 'Show').param('x', Schema.number.constant(value))
        tool.to_json_string[/"constant_value": ([^,\n]+)/, 1]
      end

      def test_small_floats_are_written_in_javascript_exponent_form
        assert_equal '1e-7', written_constant(1e-7)
        assert_equal '1.5e-7', written_constant(1.5e-7)
        assert_equal '-2.5e-8', written_constant(-2.5e-8)
      end

      def test_large_floats_are_written_in_javascript_exponent_form
        assert_equal '1e+21', written_constant(1e21)
        assert_equal '1.7976931348623157e+308', written_constant(Float::MAX)
      end

      def test_large_floats_in_the_plain_range_are_written_as_decimals
        assert_equal '123456789012345680000', written_constant(123_456_789_012_345_680_000.0)
        assert_equal '10000000000000000', written_constant(1e16)
      end

      def test_small_floats_in_the_plain_range_are_written_as_decimals
        assert_equal '0.000001', written_constant(0.000001)
        assert_equal '0.1', written_constant(0.1)
        assert_equal '1.5', written_constant(1.5)
      end

      def test_whole_floats_are_written_as_integers
        assert_equal '3', written_constant(3.0)
        assert_equal '0', written_constant(-0.0)
      end

      def test_integers_javascript_cannot_hold_are_written_as_javascript_rounds_them
        assert_equal '18446744073709552000', written_constant(2**64)
        assert_equal '9007199254740991', written_constant((2**53) - 1)
      end

      def test_to_json_string_round_trips_a_tool_with_float_constants
        tool = Tool.client('show', 'Show').param('x', Schema.number.constant(1e-7))

        assert_equal tool.to_json, Tool.from_json(tool.to_json_string).to_json
      end
    end
  end
end
