# frozen_string_literal: true

require 'minitest/autorun'
require 'json'
require 'elevenlabs'
require 'elevenlabs/agent_workflows'
require 'elevenlabs/agent_tools'

module Elevenlabs
  module AgentWorkflows
    # Some cases check a built workflow end to end, so they assert on several of its parts.
    # rubocop:disable Minitest/MultipleAssertions
    # Tool nodes and subagents that take Tool objects, which build(tool_ids:) resolves to ids.
    class ToolRefsTest < Minitest::Test
      Tool = ::Elevenlabs::AgentTools::Tool

      def get_order
        Tool.client('get_order', 'Look up an order')
      end

      def codes_of
        yield

        flunk 'expected a WorkflowValidationError'
      rescue WorkflowValidationError => e
        e.issues.map(&:code)
      end

      def test_from_json_swaps_known_tool_ids_for_tool_objects_and_keeps_unknown_ids
        tool = get_order
        wf = Workflow.new
        wf.converse('a', 'A', tool_ids: %w[tool_1 tool_other])

        loaded = Workflow.from_json(wf.to_json, tools_by_id: { 'tool_1' => tool })

        assert_equal [tool], loaded.tools
        built = JSON.generate(loaded.to_json(tool_ids: { 'get_order' => 'tool_9' }))

        assert_includes built, 'tool_9'
        assert_includes built, 'tool_other'
        refute_includes built, 'tool_1"'
      end

      def test_tool_nodes_take_tool_objects_with_overrides_keyed_by_name
        tool = get_order
        wf = Workflow.new
        wf.tool('lookup', [tool, 'tool_raw'], schema_overrides: { 'get_order' => { 'order_id' => { 'source' => 'constant', 'constant_value' => '1' } } })

        model = wf.build(tool_ids: { 'get_order' => 'tool_9' })

        assert_equal(%w[tool_9 tool_raw], model.nodes['lookup'].tools.map(&:tool_id))
        assert_equal(
          { 'schema_overrides' => { 'order_id' => { 'constant_value' => '1', 'source' => 'constant' } }, 'tool_id' => 'tool_9' },
          wf.to_json(tool_ids: { 'get_order' => 'tool_9' })['nodes']['lookup']['tools'][0],
        )
      end

      def test_two_tools_with_one_name_in_the_same_node_conflict
        wf = Workflow.new
        wf.tool('lookup', [Tool.client('get_order', 'One'), Tool.client('get_order', 'Another')])

        assert_equal(['duplicate_tool_name'], codes_of { wf.build(tool_ids: { 'get_order' => 'tool_9' }) })
      end

      def test_two_tools_with_one_name_in_different_nodes_conflict
        wf = Workflow.new
        wf.tool('a', [get_order])
        wf.tool('b', [get_order])

        assert_equal(['duplicate_tool_name'], codes_of { wf.build(tool_ids: { 'get_order' => 'tool_1' }) })
      end

      def test_the_same_tool_twice_is_fine_and_a_removed_nodes_name_can_be_reused
        tool = get_order
        wf = Workflow.new
        wf.tool('lookup', [tool, tool])
        wf.build(tool_ids: { 'get_order' => 'tool_9' })

        wf.remove('lookup')
        wf.tool('again', [get_order])

        assert_equal 1, wf.tools.length
        wf.build(tool_ids: { 'get_order' => 'tool_9' })
      end

      def test_reports_a_tool_object_without_an_id
        wf = Workflow.new
        wf.tool('a', [get_order])

        assert_equal(['unresolved_tool'], codes_of { wf.build })
        assert_equal(['unresolved_tool'], codes_of { wf.to_json(tool_ids: { 'other' => 'tool_1' }) })
      end

      def test_to_json_string_takes_tool_ids
        wf = Workflow.new
        wf.tool('lookup', [get_order])

        assert_equal wf.to_json(tool_ids: { 'get_order' => 'tool_9' }), JSON.parse(wf.to_json_string(tool_ids: { 'get_order' => 'tool_9' }))
      end

      def test_reports_overrides_for_a_tool_object_the_node_does_not_run
        wf = Workflow.new
        wf.tool('lookup', ['tool_raw'], schema_overrides: { 'get_order' => { 'order_id' => { 'source' => 'llm' } } })

        assert_equal(['invalid_option'], codes_of { wf.build })
      end

      def test_node_update_takes_tool_objects
        tool = get_order
        wf = Workflow.new
        wf.converse('a', 'A')
        wf.node('a').update(tool_ids: [tool])

        assert_equal [tool], wf.tools
        assert_equal ['tool_9'], wf.to_json(tool_ids: { get_order: 'tool_9' })['nodes']['a']['additional_tool_ids']
      end
    end
    # rubocop:enable Minitest/MultipleAssertions
  end
end
