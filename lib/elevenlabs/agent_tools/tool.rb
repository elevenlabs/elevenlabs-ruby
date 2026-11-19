# frozen_string_literal: true

require 'json'
require_relative 'errors'
require_relative 'wire'

module Elevenlabs
  module AgentTools
    # An agent tool, written as code. Create one with Tool.webhook, Tool.client or a SystemTool constructor,
    # or load one with Tool.from_json / Tool.from_response.
    #
    #   require 'elevenlabs'
    #   require 'elevenlabs/agent_tools'
    #   include Elevenlabs::AgentTools
    #
    #   get_order = Tool.webhook('get_order', 'Look up an order by the number the caller gives')
    #                   .get('https://api.example.com/orders/{order_id}')
    #                   .path_param('order_id', Schema.string.describe('The order number, e.g. A-1042'))
    #                   .header('Authorization', Header.secret('sec_orders_api'))
    #                   .options(response_timeout_secs: 10)
    #
    #   client.agents.tools.create(**get_order.build.to_h)
    class Tool
      # Options every kind of tool accepts.
      COMMON_OPTIONS = %w[
        name description response_timeout_secs interruption_mode pre_tool_speech tool_call_sound
        tool_call_sound_behavior tool_error_handling_mode
      ].freeze

      # @api private — use the static constructors. +config+ is the tool config in wire format, except the
      # parts subclasses keep in their own fields.
      def initialize(config)
        @config = config
        # Problems found while chaining, reported by build().
        @issues = []
      end

      class << self
        # A tool the server runs by calling an HTTP endpoint. Set the method and URL with get, post...
        def webhook(name, description)
          WebhookTool.new({ 'name' => name, 'description' => description }, {})
        end

        # A tool that sends an event to the user's client.
        def client(name, description)
          ClientTool.new({ 'name' => name, 'description' => description }, nil)
        end

        # Loads a tool stored in API format (snake_case), for example from to_json_string or a CLI
        # tool_configs/*.json file. Accepts a JSON string or a parsed hash: a tool config, or a request or
        # response with a +tool_config+ key. Returns a tool of the matching kind.
        def from_json(data)
          parsed = ToolWire.parse(data)
          raw = parsed.is_a?(::Hash) && parsed['tool_config'].is_a?(::Hash) ? parsed['tool_config'] : parsed
          type = raw['type']
          return OtherTool.new(raw) unless %w[webhook client system].include?(type)

          config = raw.except('type')
          case type
          when 'webhook'
            WebhookTool.load(config.except('api_schema'), config['api_schema'] || {})
          when 'client'
            parameters = config['parameters']
            ClientTool.new(config.except('parameters'),
                           parameters.nil? ? nil : Schema.from_wire_object(parameters))
          else
            params = (config['params'] || {}).dup
            system_tool_type = params.delete('system_tool_type')
            SystemTool.new(system_tool_type.to_s, config.except('params'), params)
          end
        end

        # Loads the result of tools.get (a ToolResponseModel, or its +tool_config+).
        def from_response(response)
          from_json(response.respond_to?(:tool_config) ? response.tool_config : response)
        end
      end

      # The tool's name, as the LLM sees it.
      def name
        @config['name']
      end

      # "webhook", "client", "system", or "other" for a loaded tool of a type this SDK can't edit.
      def kind
        raise NotImplementedError
      end

      # Sets options for this kind of tool. Options left as nil are unchanged. build() reports an option that
      # doesn't apply.
      #
      # All tools: +name+, +description+, +response_timeout_secs+, +interruption_mode+, +pre_tool_speech+,
      # +tool_call_sound+, +tool_call_sound_behavior+, +tool_error_handling_mode+. Webhook tools also take
      # +dynamic_variable_placeholders+, +execution_mode+, +content_type+, +response_filter+,
      # +follow_redirects+ and +follow_redirects_allowed_domains+; client tools +dynamic_variable_placeholders+,
      # +execution_mode+ and +expects_response+ (wait for the client to respond, and pass its response to the
      # LLM). Enum values may be strings or symbols; nested values may be generated models or hashes.
      def options(name: nil, description: nil, response_timeout_secs: nil, interruption_mode: nil,
                  pre_tool_speech: nil, tool_call_sound: nil, tool_call_sound_behavior: nil,
                  tool_error_handling_mode: nil, dynamic_variable_placeholders: nil, execution_mode: nil,
                  content_type: nil, response_filter: nil, follow_redirects: nil,
                  follow_redirects_allowed_domains: nil, expects_response: nil)
        given = {
          'name' => name, 'description' => description, 'response_timeout_secs' => response_timeout_secs,
          'interruption_mode' => interruption_mode, 'pre_tool_speech' => pre_tool_speech,
          'tool_call_sound' => tool_call_sound, 'tool_call_sound_behavior' => tool_call_sound_behavior,
          'tool_error_handling_mode' => tool_error_handling_mode,
          'dynamic_variable_placeholders' => dynamic_variable_placeholders, 'execution_mode' => execution_mode,
          'content_type' => content_type, 'response_filter' => response_filter,
          'follow_redirects' => follow_redirects, 'follow_redirects_allowed_domains' => follow_redirects_allowed_domains,
          'expects_response' => expects_response
        }
        given.each do |key, value|
          next if value.nil?

          if allowed_options.include?(key)
            set_option(key, ToolWire.value(value))
          else
            @issues << ToolIssue.error('invalid_option', key, "Option \"#{key}\" doesn't apply to #{kind} tools")
          end
        end
        self
      end

      # This tool as a WebhookTool, or nil if it's another kind.
      def as_webhook
        is_a?(WebhookTool) ? self : nil
      end

      # This tool as a ClientTool, or nil if it's another kind.
      def as_client
        is_a?(ClientTool) ? self : nil
      end

      # This tool as a SystemTool, or nil if it's another kind.
      def as_system
        is_a?(SystemTool) ? self : nil
      end

      # Validates the tool and returns it as the model tools.create and tools.update accept
      # (Elevenlabs::Types::ToolRequestModel). +on_warning+ is a callable invoked once per non-fatal problem.
      # Raises ToolValidationError listing every problem, if the tool is invalid.
      def build(on_warning: nil)
        ::Elevenlabs::Types::ToolRequestModel.load(::JSON.generate('tool_config' => validated_wire(on_warning)))
      end

      # Validates the tool and returns only its config: for a system tool, its entry in the agent's
      # prompt.built_in_tools. Create webhook and client tools with tools.create and attach them by id in
      # prompt.tool_ids; the inline prompt.tools field is deprecated, and replaces built_in_tools with the
      # system tools it contains. Raises ToolValidationError listing every problem, if the tool is invalid.
      def build_config(on_warning: nil)
        ::Elevenlabs::Types::ToolRequestModelToolConfig.load(::JSON.generate(validated_wire(on_warning)))
      end

      # The tool config in API format (snake_case keys, sorted at every level), the shape of a CLI
      # tool_configs/*.json file. Validates like build().
      def to_json(*_args)
        ToolWire.canonical(validated_wire(nil))
      end

      # to_json as a string with 2-space indentation and a trailing newline: the canonical file format, byte
      # for byte what the JavaScript SDK writes (numbers included).
      def to_json_string
        "#{ToolWire.json_string(to_json)}\n"
      end

      protected

      def allowed_options
        COMMON_OPTIONS
      end

      def set_option(key, value)
        if key == 'dynamic_variable_placeholders'
          @config['dynamic_variables'] = (@config['dynamic_variables'] || {}).merge(key => value)
        else
          @config[key] = value
        end
      end

      # Problems that need the finished tool.
      def validate_tool
        []
      end

      # The tool config in wire format, unsorted.
      def to_wire
        raise NotImplementedError
      end

      private

      def validated_wire(on_warning)
        issues = @issues + validate_tool
        errors = issues.select { |issue| issue.severity == 'error' }
        raise ToolValidationError.new(name, errors) unless errors.empty?

        issues.each { |issue| on_warning.call(issue) if issue.severity == 'warning' } unless on_warning.nil?
        ToolWire.deep_copy(to_wire)
      end
    end

    # A loaded tool of a type the builder has no constructor for, such as +mcp+. Kept exactly as loaded.
    class OtherTool < Tool
      def kind
        'other'
      end

      protected

      def allowed_options
        []
      end

      def validate_tool
        [
          ToolIssue.new(
            code: 'unknown_tool_type',
            severity: 'warning',
            message: "Tool \"#{name}\" has type \"#{@config['type']}\", which this SDK can't edit. It round-trips " \
                     "through to_json, but build()'s output may be rejected by tools.create and tools.update",
          ),
        ]
      end

      def to_wire
        @config
      end
    end
  end
end
