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

      # Sets the param +name+. Required unless the schema is optional. Any schema kind. Loaded parameters
      # that aren't an object are left as they are, and build() reports them.
      def param(name, schema)
        @parameters = Schema.object if @parameters.nil?
        @parameters = @parameters.property(name, schema) if @parameters.is_a?(ObjectSchema)
        self
      end

      # Removes the param +name+. Removing the last one leaves +parameters+ out.
      def remove_param(name)
        return self unless @parameters.is_a?(ObjectSchema) && @parameters.property_names.include?(name)

        @parameters = @parameters.without(name)
        @parameters = nil if @parameters.property_names.empty?
        self
      end

      # The params as an ObjectSchema (or the schema as loaded, if it isn't an object), or nil if there are none.
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
        unless @parameters.nil?
          issues << ToolIssue.error('body_not_object', 'params', 'The params schema must be an object') unless @parameters.is_a?(ObjectSchema)
          Validate.check_schema(@parameters, 'params', false, issues)
        end
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
