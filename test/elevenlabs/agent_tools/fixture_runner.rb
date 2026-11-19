# frozen_string_literal: true

require 'json'
require 'elevenlabs'
require 'elevenlabs/agent_tools'

module Elevenlabs
  module AgentTools
    # Interprets the language-neutral fixtures in fixtures/, copied from the reference SDK
    # (elevenlabs-js, docs/agents-as-code/fixtures/tools). See tool-spec.md there, "Fixtures".
    module FixtureRunner
      SYSTEM_CONSTRUCTORS = %w[
        end_call skip_turn language_detection play_keypad_touch_tone voicemail_detection knowledge_base
        transfer_to_number transfer_to_agent
      ].freeze
      # Ops whose argument at this index is a schema, given in wire format or as {"build": [ops]}.
      SCHEMA_ARG = {
        'path_param' => 1, 'query_param' => 1, 'body' => 0, 'response' => 0, 'param' => 1, 'property' => 1
      }.freeze
      # Ops whose trailing options object becomes keyword arguments.
      KWARG_OPS = %w[options assign transfer].freeze

      module_function

      def snake(name)
        name.gsub(/(?<!^)(?=[A-Z])/, '_').downcase
      end

      # Option keys are canonical camelCase names; values are in API wire format, passed verbatim.
      def kwargs(raw)
        (raw || {}).to_h { |key, value| [snake(key).to_sym, value] }
      end

      def destination(raw)
        return Destination.phone(raw['phone']) if raw.key?('phone')
        return Destination.phone_variable(raw['phoneVariable']) if raw.key?('phoneVariable')
        return Destination.sip(raw['sip']) if raw.key?('sip')
        return Destination.sip_variable(raw['sipVariable']) if raw.key?('sipVariable')

        Destination.agent(raw['agent'], node_id: raw['nodeId'])
      end

      def header(raw)
        return Header.value(raw['value']) if raw.key?('value')
        return Header.secret(raw['secret']) if raw.key?('secret')
        return Header.variable(raw['variable']) if raw.key?('variable')

        Header.env_var(raw['envVar'])
      end

      def auth(raw)
        raw.key?('id') ? AuthConnection.id(raw['id']) : AuthConnection.env_var(raw['envVar'])
      end

      # A schema argument is wire-format JSON, or {"build": [ops]} for one built with Schema methods.
      def schema_arg(raw)
        raw.key?('build') ? build_schema(raw['build']) : Schema.from_json(raw)
      end

      # Calls one op on +target+: positional args, plus keyword args from a trailing options object.
      def call(target, op)
        method = snake(op['op'])
        args = (op['args'] || []).dup
        index = SCHEMA_ARG[method]
        args[index] = schema_arg(args[index]) unless index.nil?
        args[1] = header(args[1]) if method == 'header'
        args[0] = auth(args[0]) if method == 'auth'
        args[1] = destination(args[1]) if method == 'transfer'
        options = {}
        if method == 'options'
          options = kwargs(args.shift)
        elsif KWARG_OPS.include?(method) && args.length > 2
          options = kwargs(args.pop)
        end
        raise "Unknown fixture op #{op['op'].inspect}" unless target.respond_to?(method)

        target.public_send(method, *args, **options)
      end

      def build_schema(ops)
        first, *rest = ops
        schema = case first['op']
                 when 'array' then Schema.array(schema_arg(first['args'][0]))
                 when 'fromJSON' then Schema.from_json(first['args'][0])
                 else Schema.public_send(first['op'])
                 end
        rest.reduce(schema) { |current, op| call(current, op) }
      end

      def tool_for(fixture)
        return Tool.from_json(fixture['from']) if fixture.key?('from')

        spec = fixture['tool']
        return Tool.webhook(*spec['webhook']) if spec.key?('webhook')
        return Tool.client(*spec['client']) if spec.key?('client')

        system = spec['system']
        raise "Unknown system tool #{system.inspect}" unless SYSTEM_CONSTRUCTORS.include?(system)

        SystemTool.public_send(system, **kwargs(spec['systemOptions']))
      end

      # Runs a fixture and returns { json: ... } with the canonical JSON string, or { errors: [...] }.
      def run_fixture(fixture)
        return { json: "#{::JSON.pretty_generate(build_schema(fixture['schema']).to_json)}\n" } if fixture.key?('schema')

        tool = tool_for(fixture)
        (fixture['ops'] || []).each { |op| call(tool, op) }
        begin
          { json: tool.to_json_string }
        rescue ToolValidationError => e
          { errors: e.issues.map(&:code) }
        end
      end
    end
  end
end
