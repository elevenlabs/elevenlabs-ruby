# frozen_string_literal: true

require_relative 'support'

module Elevenlabs
  module AgentTools
    class LoadingTest < Minitest::Test
      include Support

      MCP = { 'name' => 'search', 'type' => 'mcp', 'mcp_server_id' => 'mcp_1' }.freeze

      def empty_bodies
        Tool.from_json(
          'name' => 't', 'description' => 'T', 'type' => 'webhook',
          'api_schema' => { 'url' => 'https://api.example.com/t', 'method' => 'POST',
                            'request_body_schema' => {}, 'response_body_schema' => {} }
        ).as_webhook
      end

      def test_loads_empty_webhook_body_and_response_schemas_with_no_type_as_objects
        tool = empty_bodies

        assert_equal %w[object object], [tool.body_schema.kind, tool.response_schema.kind]
      end

      def test_loads_a_request_wrapper_with_a_tool_config_key
        config = get_order.to_json

        assert_equal config, Tool.from_json('tool_config' => config).to_json
      end

      def test_loads_a_json_string
        assert_equal get_order.to_json, Tool.from_json(get_order.to_json_string).to_json
      end

      def test_loads_symbol_keys
        assert_equal get_order.to_json, Tool.from_json(::JSON.parse(get_order.to_json_string, symbolize_names: true)).to_json
      end

      def test_reads_nulls_as_absent
        raw = get_order.to_json.merge('response_timeout_secs' => nil)

        assert_equal get_order.to_json, Tool.from_json(raw).to_json
      end

      def test_loads_the_result_of_tools_get
        response = ::Elevenlabs::Types::ToolResponseModel.load(
          ::JSON.generate('id' => 'tool_1', 'tool_config' => get_order.to_json),
        )

        assert_equal get_order.to_json, Tool.from_response(response).to_json
      end

      def test_loads_the_kind
        assert_equal(%w[webhook client system other],
                     [get_order, Tool.client('c', 'C'), SystemTool.end_call, Tool.from_json(MCP)].map { |tool| Tool.from_json(tool.to_json).kind })
      end

      def test_as_returns_nil_for_another_kind
        tool = Tool.from_json(MCP)

        assert_equal [nil, nil, nil], [tool.as_webhook, tool.as_client, tool.as_system]
      end

      def test_keeps_a_tool_of_an_unknown_type
        assert_equal({ 'mcp_server_id' => 'mcp_1', 'name' => 'search', 'type' => 'mcp' }, Tool.from_json(MCP).to_json)
      end

      def test_warns_when_a_tool_of_an_unknown_type_is_built
        warnings = []
        Tool.from_json(MCP).build(on_warning: ->(issue) { warnings << issue.code })

        assert_equal ['unknown_tool_type'], warnings
      end

      def test_keeps_a_loaded_system_tool_type_the_builder_has_no_constructor_for
        raw = {
          'name' => 'start_procedure',
          'params' => { 'procedures' => { 'refund' => { 'procedure_id' => 'proc_1' } }, 'system_tool_type' => 'start_procedure' },
          'type' => 'system',
        }

        assert_equal raw, Tool.from_json(raw).to_json
      end

      def test_keeps_loaded_fields_the_builder_does_not_model
        raw = get_order.to_json.merge('future_field' => { 'a' => 1 })

        assert_equal raw, Tool.from_json(raw).to_json
      end
    end
  end
end
