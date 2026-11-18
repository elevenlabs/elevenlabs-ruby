# frozen_string_literal: true

require 'minitest/autorun'
require 'elevenlabs'
require 'elevenlabs/agent_workflows'

module Elevenlabs
  module AgentWorkflows
    # A backward condition is a second transition (target → source) the API stores on the same edge.
    # It must obey the same routing rules as any outgoing edge, so validate() checks the reverse
    # direction too.
    class BackwardTest < Minitest::Test
      def codes_for
        yield

        flunk 'expected build to fail'
      rescue WorkflowValidationError => e
        e.issues.map(&:code)
      end

      def test_backward_condition_into_start_is_rejected
        wf = Workflow.new
        wf.when('Begin', back: 'Restart').converse('greet', 'Hello')

        assert_includes codes_for { wf.build }, 'edge_into_start'
      end

      def test_backward_condition_out_of_end_is_rejected
        wf = Workflow.new
        wf.converse('triage', 'Triage').when('Done', back: 'Resume').end

        assert_includes codes_for { wf.build }, 'end_has_outgoing_edges'
      end

      def test_backward_loop_between_converse_nodes_is_allowed
        wf = Workflow.new
        a = wf.converse('a', 'A')
        a.when('To B', back: 'Back to A').converse('b', 'B').end
        wf.build # must not raise
      end

      def test_insert_between_bidirectional_edge_is_rejected
        wf = Workflow.new
        a = wf.converse('a', 'A')
        a.when('to b', back: 'back to a').converse('b', 'B') # a <-> b
        result = wf.insert_between('a', 'b', ->(br) { br.converse('mid', 'M') })

        assert_nil result, 'inserting into a bidirectional edge must be rejected'
        assert_includes codes_for { wf.build }, 'cannot_insert_bidirectional'
      end

      def test_position_accepted_for_unmapped_node_types
        fc = Condition.llm('go').to_wire
        wire = {
          'nodes' => {
            'start_node' => { 'type' => 'start' },
            'announce' => { 'type' => 'say', 'text' => 'hello' },
          },
          'edges' => {
            'start_node__announce' => { 'source' => 'start_node', 'target' => 'announce', 'forward_condition' => fc },
          },
        }
        wf = Workflow.from_json(wire)
        wf.node('announce').update(position: { 'x' => 10, 'y' => 20 })
        wf.build # position must be accepted on a node kind with no dedicated field map
      end

      def test_loaded_backward_only_edge_has_no_forward_transition
        fc = Condition.llm('go').to_wire
        bc = Condition.llm('restart').to_wire
        wire = {
          'nodes' => {
            'start_node' => { 'type' => 'start' },
            'hub' => { 'type' => 'override_agent', 'label' => 'hub', 'additional_prompt' => 'H' },
            'x' => { 'type' => 'override_agent', 'label' => 'x', 'additional_prompt' => 'X' },
            'end' => { 'type' => 'end' },
          },
          'edges' => {
            'e1' => { 'source' => 'start_node', 'target' => 'hub', 'forward_condition' => fc },
            'e2' => { 'source' => 'hub', 'target' => 'x', 'forward_condition' => fc },
            'e3' => { 'source' => 'hub', 'target' => 'end', 'forward_condition' => fc },
            'e4' => { 'source' => 'x', 'target' => 'start_node', 'backward_condition' => bc },
          },
        }
        out = Workflow.from_json(wire).to_json

        refute_includes out['nodes']['x']['edge_order'], 'e4',
                        'x has no forward transition via e4, so it must not be in x edge_order'
      end
    end
  end
end
