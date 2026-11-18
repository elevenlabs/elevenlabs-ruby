# frozen_string_literal: true

module Elevenlabs
  module AgentTools
    # The validation issue codes build() can report. Mirrors the shared tool spec.
    ISSUE_CODES = %w[
      missing_url
      missing_path_param
      unknown_path_param
      param_not_literal
      body_not_object
      body_not_allowed
      missing_body
      duplicate_param
      conflicting_value_source
      omitted_required
      invalid_choices
      allowed_values_needs_description
      constant_type_mismatch
      unknown_required_property
      missing_array_items
      duplicate_header
      invalid_destination
      no_transfers
      invalid_option
      missing_value_source
      unknown_tool_type
    ].freeze

    # A problem found in a tool. Errors stop build(); warnings are passed to its on_warning callback.
    # +path+ says where the problem is, for example "body.reason" or "path_params.order_id".
    class ToolIssue
      attr_reader :code, :severity, :message, :path

      def initialize(code:, severity:, message:, path: nil)
        @code = code
        @severity = severity
        @message = message
        @path = path
        freeze
      end

      # @api private
      def self.error(code, path, message)
        new(code: code, severity: 'error', message: message, path: path)
      end

      def ==(other)
        other.is_a?(ToolIssue) &&
          other.code == code && other.severity == severity &&
          other.message == message && other.path == path
      end
      alias eql? ==

      def hash
        [code, severity, message, path].hash
      end
    end

    # Raised by a tool's build() when the tool is invalid. Lists every problem found.
    class ToolValidationError < StandardError
      attr_reader :issues

      def initialize(name, issues)
        @issues = issues
        super("Invalid tool \"#{name}\":\n#{issues.map { |issue| "  - #{issue.message}" }.join("\n")}")
      end
    end
  end
end
