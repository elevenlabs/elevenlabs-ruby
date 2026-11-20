# frozen_string_literal: true

module Elevenlabs
  module AgentWorkflows
    # The validation issue codes build() can report. Mirrors the shared workflow spec.
    ISSUE_CODES = %w[
      duplicate_node_id
      unknown_node
      unknown_edge
      duplicate_edge
      self_loop
      invalid_option
      edge_into_start
      end_has_outgoing_edges
      tool_edge_needs_result
      result_edge_needs_tool
      cannot_remove_start
      missing_insert_result
      unreachable_node
      unknown_node_type
      duplicate_tool_name
      unresolved_tool
    ].freeze

    # A problem found in a workflow. Errors stop build(); warnings are passed to its on_warning callback.
    class WorkflowIssue
      attr_reader :code, :severity, :message, :node_id

      def initialize(code:, severity:, message:, node_id: nil)
        @code = code
        @severity = severity
        @message = message
        @node_id = node_id
        freeze
      end

      def ==(other)
        other.is_a?(WorkflowIssue) &&
          other.code == code && other.severity == severity &&
          other.message == message && other.node_id == node_id
      end
      alias eql? ==

      def hash
        [code, severity, message, node_id].hash
      end
    end

    # Raised by Workflow#build when the workflow is invalid. Lists every problem found.
    class WorkflowValidationError < StandardError
      attr_reader :issues

      def initialize(issues)
        @issues = issues
        super("Invalid workflow:\n#{issues.map { |issue| "  - #{issue.message}" }.join("\n")}")
      end
    end
  end
end
