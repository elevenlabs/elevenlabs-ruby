# frozen_string_literal: true

require_relative 'support'

module Elevenlabs
  module AgentTools
    class ClientToolTest < Minitest::Test
      include Support

      def client_tool(parameters)
        Tool.from_json('name' => 't', 'description' => 'T', 'type' => 'client', 'parameters' => parameters)
      end

      def test_build_holds_the_generated_client_config
        tool = Tool.client('show', 'Show').param('x', Schema.string.describe('X'))

        assert_instance_of ::Elevenlabs::Types::ClientToolConfigInput, tool.build.tool_config
      end

      def test_loads_empty_params_with_no_type_as_an_object
        assert_equal 'object', client_tool({}).as_client.parameters_schema.kind
      end

      def test_can_add_to_loaded_empty_params
        client_tool({}).as_client.param('x', Schema.string.describe('X')).build
      end

      def test_checks_require_any_of_on_the_params_object_against_the_params_it_still_has
        tool = client_tool(
          'type' => 'object',
          'properties' => { 'a' => { 'type' => 'string', 'description' => 'A' },
                            'b' => { 'type' => 'string', 'description' => 'B' } },
          'required_constraints' => { 'any_of' => [{ 'required' => %w[a b] }] },
        ).as_client
        tool.build
        tool.remove_param('b')

        assert_equal([%w[unknown_required_property params]], codes_and_paths_of { tool.build })
      end

      def test_removes_params
        tool = Tool.client('show', 'Show something')
                   .param('a', Schema.string.describe('A'))
                   .param('b', Schema.string.describe('B'))
                   .remove_param('a')

        assert_equal ['b'], tool.parameters_schema.property_names
      end

      def test_leaves_parameters_out_when_there_are_none
        assert_equal({ 'description' => 'Ping the client', 'name' => 'ping', 'type' => 'client' },
                     Tool.client('ping', 'Ping the client').to_json)
      end

      def test_accepts_response_timeouts_from_1_to_120_seconds_or_minus_1_with_expects_response
        [{ response_timeout_secs: 1 }, { response_timeout_secs: 120 },
         { response_timeout_secs: -1, expects_response: true }].each do |options|
          Tool.client('wait', 'Wait').options(**options).build
        end
      end

      def test_rejects_other_response_timeouts
        codes = [0, 121, -1].map { |secs| codes_of { Tool.client('wait', 'Wait').options(response_timeout_secs: secs).build } }

        assert_equal [['invalid_option']] * 3, codes
      end

      def test_treats_an_empty_description_or_variable_name_as_no_source
        codes = [Schema.string.describe(''), Schema.string.from_variable('')].map do |schema|
          codes_of { Tool.client('t', 'T').param('x', schema).build }
        end

        assert_equal [['missing_value_source']] * 2, codes
      end

      def test_allowed_from_needs_a_non_empty_description
        assert_equal(%w[allowed_values_needs_description missing_value_source],
                     codes_of { Tool.client('t', 'T').param('x', Schema.string.describe('').allowed_from('fares')).build })
      end

      def test_accepts_a_constant_of_a_nullable_literal_type_and_writes_the_type_back
        [[%w[integer null], 42], [%w[number null], 1.5], [%w[boolean null], true]].each do |type, value|
          raw = { 'description' => 'T', 'name' => 't', 'type' => 'client',
                  'parameters' => { 'properties' => { 'x' => { 'constant_value' => value, 'type' => type } },
                                    'required' => ['x'], 'type' => 'object' } }

          assert_equal raw, Tool.from_json(raw).to_json
        end
      end

      def test_still_rejects_a_constant_of_the_wrong_type_for_a_nullable_literal
        tool = client_tool('type' => 'object',
                           'properties' => { 'x' => { 'type' => %w[integer null], 'constant_value' => 'a' } })

        assert_equal(['constant_type_mismatch'], codes_of { tool.build })
      end

      def test_accepts_a_null_constant_set_on_a_nullable_literal
        tool = Tool.client('t', 'T').param('x', Schema.from_json('type' => %w[integer null]).constant(nil))

        assert_equal({ 'constant_value' => nil, 'type' => %w[integer null] },
                     tool.to_json['parameters']['properties']['x'])
      end
    end
  end
end
