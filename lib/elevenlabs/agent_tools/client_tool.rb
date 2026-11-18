# frozen_string_literal: true

require_relative 'errors'
require_relative 'schema'
require_relative 'tool'
require_relative 'validate'

module Elevenlabs
  module AgentTools
    # A tool that sends an event to the user's client.
    class ClientTool < Tool
      OPTIONS = (COMMON_OPTIONS + %w[dynamic_variable_placeholders execution_mode expects_response]).freeze

      # @api private — use Tool.client. +parameters+ is an ObjectSchema, or nil.
      def initialize(config, parameters)
        super(config)
        @parameters = parameters
      end

      def kind
        'client'
      end

      # Sets the param +name+. Required unless the schema is optional. Any schema kind.
      def param(name, schema)
        @parameters = (@parameters || Schema.object).property(name, schema)
        self
      end

      # Removes the param +name+.
      def remove_param(name)
        @parameters = @parameters&.without(name)
        self
      end

      # The params as an ObjectSchema, or nil if there are none.
      def parameters_schema
        @parameters
      end

      protected

      def allowed_options
        OPTIONS
      end

      def validate_tool
        issues = []
        # Checks the params object's own require_any_of/require_all_of and every param under it.
        Validate.check_schema(@parameters, 'params', false, issues) unless @parameters.nil?
        timeout = @config['response_timeout_secs']
        if timeout.is_a?(::Numeric) && timeout != -1 && (timeout < 1 || timeout > 120)
          issues << ToolIssue.error('invalid_option', 'response_timeout_secs',
                                    "A client tool's response_timeout_secs must be 1–120, or -1")
        end
        if timeout == -1 && @config['expects_response'] != true
          issues << ToolIssue.error('invalid_option', 'response_timeout_secs',
                                    'response_timeout_secs: -1 needs expects_response: true')
        end
        issues
      end

      def to_wire
        wire = @config.merge('type' => 'client')
        wire['parameters'] = @parameters.to_wire unless @parameters.nil?
        wire
      end
    end
  end
end
