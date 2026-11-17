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
    end
  end
end
