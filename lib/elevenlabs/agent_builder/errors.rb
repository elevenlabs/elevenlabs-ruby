# frozen_string_literal: true

module Elevenlabs
  module AgentBuilder
    # The validation issue codes Agent#validate, #to_json and #build can report. Mirrors the shared agent spec.
    ISSUE_CODES = %w[
      missing_name
      missing_prompt
      duplicate_tool_name
      invalid_tool
      invalid_workflow
      invalid_config
      option_conflict
      unresolved_tool
      system_tool_in_workflow
    ].freeze

    # A problem found in an agent. Errors stop validate, to_json and build; warnings are passed to their
    # +on_warning+ callable. +path+ says where the problem is, for example "tools.get_order" or "workflow".
    class AgentIssue
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
        other.is_a?(AgentIssue) &&
          other.code == code && other.severity == severity &&
          other.message == message && other.path == path
      end
      alias eql? ==

      def hash
        [code, severity, message, path].hash
      end
    end

    # Raised by Agent#validate, #to_json and #build when the agent is invalid. Lists every problem found.
    class AgentValidationError < StandardError
      attr_reader :issues

      def initialize(name, issues)
        @issues = issues
        super("Invalid agent \"#{name}\":\n#{issues.map { |issue| "  - #{issue.message}" }.join("\n")}")
      end
    end

    # Raised when a project's files can't be read or written: a missing or malformed file, a path outside the
    # project, or a format the SDK can't read yet (YAML and TOML configs).
    class AgentProjectError < StandardError; end

    # What agents.push did to one tool. +action+ is "created", "updated", "unchanged" or "detached" (the agent
    # used the tool before and no longer does; it isn't deleted).
    ToolPushResult = Data.define(:id, :action)

    # What agents.push did. +action+ is "created" or "updated"; +tools+ maps each tool push touched, by name,
    # to a ToolPushResult.
    AgentPushResult = Data.define(:agent_id, :action, :tools)

    # What agents.push wrote before a request failed. +agent_id+ and +action+ are set once the agent is.
    PartialAgentPushResult = Struct.new(:tools, :agent_id, :action) do
      def initialize(tools: {}, agent_id: nil, action: nil)
        super
      end
    end

    # Raised by agents.push when an API call fails after it started writing. +result+ (a
    # PartialAgentPushResult) lists what was written before the failure, so nothing created goes unreported;
    # with a project, those ids are saved to it too. +step+ names the step that failed, for example
    # Couldn't create tool "get_order", and +cause+ is the failed call's exception.
    class AgentPushError < StandardError
      attr_reader :step, :result

      def initialize(step, result, cause)
        @step = step
        @result = result
        @push_cause = cause
        super("#{step}: #{cause.message}")
      end

      # The failed call's exception. Ruby also sets it as the standard +cause+ when this is raised from the
      # rescue block, as agents.push does.
      def cause
        @push_cause || super
      end
    end
  end
end
