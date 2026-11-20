# frozen_string_literal: true

require 'json'
require_relative 'errors'
require_relative 'wire'

module Elevenlabs
  module AgentBuilder
    # An agent, written as code: its settings, its tools and its workflow in one definition. Push it with
    # +client.agents.push(agent)+, which creates or updates the tools and the agent together.
    #
    #   require 'elevenlabs'
    #   require 'elevenlabs/agent_builder'
    #   include Elevenlabs::AgentBuilder
    #   include Elevenlabs::AgentTools
    #
    #   agent = Agent.new(
    #     'Support line',
    #     prompt: 'You are a support agent for Acme.',
    #     first_message: 'Hi, how can I help?',
    #     tools: [SystemTool.end_call, get_order],
    #     workflow: wf,
    #   )
    #   result = client.agents.push(agent)
    class Agent
      # Where each typed option goes in the agent config, in API format. The generated models declare each
      # step (checked by the tests), so a renamed field shows up there.
      TYPED_OPTIONS = {
        'prompt' => %w[conversation_config agent prompt prompt],
        'first_message' => %w[conversation_config agent first_message],
        'language' => %w[conversation_config agent language],
        'llm' => %w[conversation_config agent prompt llm],
        'temperature' => %w[conversation_config agent prompt temperature],
        'voice_id' => %w[conversation_config tts voice_id],
        'tts_model' => %w[conversation_config tts model_id],
      }.freeze

      TOOL_IDS_PATH = %w[conversation_config agent prompt tool_ids].freeze
      BUILT_IN_TOOLS_PATH = %w[conversation_config agent prompt built_in_tools].freeze
      PROMPT_PATH = TYPED_OPTIONS['prompt']
      SYSTEM_TYPE = { 'type' => 'system' }.freeze
      private_constant :SYSTEM_TYPE

      # +prompt+ is the agent's instructions (conversation_config.agent.prompt.prompt), +first_message+ what
      # it says first, +language+ e.g. "en", +llm+ and +temperature+ the model settings, +voice_id+ and
      # +tts_model+ the voice (conversation_config.tts). Enum values may be strings or symbols.
      #
      # +tools+ are the tools the agent can use anywhere: webhook and client tools are created or updated by
      # agents.push and attached by id; system tools go into prompt.built_in_tools. +tool_ids+ attaches
      # existing tools as they are; agents.push doesn't create or change them. +workflow+ is the agent's
      # Workflow, whose tool nodes can take Tool objects that agents.push manages too.
      #
      # +conversation_config+ and +platform_settings+ take any other setting, as the generated models
      # (Elevenlabs::Types::ConversationalConfig, AgentPlatformSettingsRequestModel) or as wire-format
      # (snake_case) hashes, merged under the options above. Setting a field there that an option above also
      # sets is reported by validate.
      def initialize(name, prompt: nil, first_message: nil, language: nil, llm: nil, temperature: nil,
                     voice_id: nil, tts_model: nil, tags: nil, tools: nil, tool_ids: nil, workflow: nil,
                     conversation_config: nil, platform_settings: nil)
        @name = name
        @typed = {}
        @tags = nil
        @tools = []
        @tool_ids = []
        @workflow = nil
        # A loaded workflow nobody has edited yet, kept in API format so it round-trips exactly.
        @raw_workflow = nil
        @tools_by_id = {}
        # The loaded tool_ids, so a loaded agent keeps its tool order.
        @loaded_tool_ids = []
        # Whether tools or tool_ids was given (even empty), so the agent sets tool_ids rather than leaving it.
        @tool_list_given = false
        # Loaded system tools, by identity: [config as loaded, its to_json_string as loaded]. Sent as loaded
        # while the tool is unchanged.
        @loaded_system = {}.compare_by_identity
        # Settings loaded from a config, in API format. Typed options and raw options are applied on top.
        @base = {}
        @raw_conversation_config = []
        @raw_platform_settings = []
        update(prompt: prompt, first_message: first_message, language: language, llm: llm,
               temperature: temperature, voice_id: voice_id, tts_model: tts_model, tags: tags, tools: tools,
               tool_ids: tool_ids, workflow: workflow, conversation_config: conversation_config,
               platform_settings: platform_settings)
      end

      class << self
        # Loads an agent config in API format (snake_case): a CLI agent_configs/*.json file, or the to_json of
        # an agent, as a JSON string or a parsed hash. Tool ids found in +tools_by_id+ (a hash of id => Tool)
        # of webhook and client tools become Tool objects the agent manages; the rest stay as tool_ids. Fields this SDK doesn't model are
        # kept, so an unedited agent round-trips exactly.
        def from_json(config, tools_by_id: nil)
          parsed = config.is_a?(::String) ? ::JSON.parse(config) : AgentWorkflows::Wire.to_wire(config)
          raise ArgumentError, 'An agent config must be a JSON object' unless parsed.is_a?(::Hash)

          base = AgentWire.deep_copy(parsed)
          name = base.delete('name')
          tags = base.delete('tags')
          workflow = base.delete('workflow')
          agent = new(name.is_a?(::String) ? name : '')
          agent.send(:load_config, base, tags, workflow, (tools_by_id || {}).to_h { |id, tool| [id.to_s, tool] })
          agent
        end
      end

      # The agent's name.
      attr_reader :name

      # The agent's Workflow, or nil if it has none. A loaded workflow is turned into a Workflow the first
      # time it's read here, with its tool ids swapped for the Tool objects the agent knows, so it can be
      # edited.
      def workflow
        if @workflow.nil? && !@raw_workflow.nil?
          @workflow = AgentWorkflows::Workflow.from_json(@raw_workflow, tools_by_id: @tools_by_id)
          @raw_workflow = nil
        end
        @workflow
      end

      # Changes the agent. Options left as nil are unchanged. +name+, the typed options, +tags+, +tools+,
      # +tool_ids+ and +workflow+ replace what was there; +conversation_config+ and +platform_settings+ merge.
      def update(name: nil, prompt: nil, first_message: nil, language: nil, llm: nil, temperature: nil,
                 voice_id: nil, tts_model: nil, tags: nil, tools: nil, tool_ids: nil, workflow: nil,
                 conversation_config: nil, platform_settings: nil)
        @name = name unless name.nil?
        {
          'prompt' => prompt, 'first_message' => first_message, 'language' => language, 'llm' => llm,
          'temperature' => temperature, 'voice_id' => voice_id, 'tts_model' => tts_model
        }.each { |key, value| @typed[key] = value unless value.nil? }
        @tags = tags.to_a unless tags.nil?
        unless tools.nil?
          @tools = tools.to_a.dup
          @tool_list_given = true
        end
        unless tool_ids.nil?
          @tool_ids = tool_ids.to_a.map(&:to_s)
          @tool_list_given = true
        end
        unless workflow.nil?
          @workflow = workflow
          @raw_workflow = nil
        end
        @raw_conversation_config << conversation_config unless conversation_config.nil?
        @raw_platform_settings << platform_settings unless platform_settings.nil?
        self
      end

      # Adds a tool the agent can use anywhere.
      def add_tool(tool)
        @tools << tool
        @tool_list_given = true
        self
      end

      # Every webhook and client tool the agent and its workflow use, each once, in first-use order: the tools
      # agents.push creates or updates. System tools aren't included; they live inside the agent's config.
      # Other kinds (such as MCP tools) aren't either: they stay attached by the id the agent was loaded with.
      def tools
        seen = {}.compare_by_identity
        (@tools + workflow_tools).each_with_object([]) do |tool, result|
          next if !managed?(tool) || seen.key?(tool)

          seen[tool] = true
          result << tool
        end
      end

      # The ids of existing tools attached as they are, which agents.push doesn't manage.
      def tool_ids
        @tool_ids.dup
      end

      # Checks everything that doesn't need tool ids: the tools, the workflow, the settings, and that no two
      # tools share a name. CI can run this without an API key. +on_warning+ is a callable invoked once per
      # non-fatal problem, such as an agent without a prompt. Raises AgentValidationError listing every
      # problem, if the agent is invalid.
      def validate(on_warning: nil)
        assemble(nil, on_warning)
        nil
      end

      # Validates the agent and returns the request agents.create takes, as the generated model
      # (Elevenlabs::Agents::Types::BodyCreateAgentV1ConvaiAgentsCreatePost; agents.update takes the same
      # fields). +tool_ids+ maps the name of each webhook and client tool the agent uses to its id;
      # agents.push passes it after creating or updating the tools. Raises AgentValidationError listing
      # every problem, if the agent is invalid or a tool has no id.
      def build(tool_ids: nil, on_warning: nil)
        ::Elevenlabs::Agents::Types::BodyCreateAgentV1ConvaiAgentsCreatePost.load(
          ::JSON.generate(to_json(tool_ids: tool_ids, on_warning: on_warning)),
        )
      end

      # The agent config in API format (snake_case keys, sorted at every level): the shape of a CLI
      # agent_configs/*.json file. Validates like build, and also needs every tool's id in +tool_ids+.
      def to_json(*_args, tool_ids: nil, on_warning: nil)
        assemble((tool_ids || {}).to_h { |key, id| [key.to_s, id] }, on_warning)
      end

      def inspect
        "#<#{self.class.name} name=#{@name.inspect}>"
      end

      private

      def load_config(base, tags, workflow, tools_by_id)
        @base = base
        @tags = tags.is_a?(::Array) ? tags : nil
        @tools_by_id = tools_by_id
        ids = AgentWire.get_path(base, TOOL_IDS_PATH)
        if ids.is_a?(::Array)
          AgentWire.delete_path(base, TOOL_IDS_PATH)
          @loaded_tool_ids = ids.dup
          @tool_list_given = true
          ids.each do |id|
            tool = tools_by_id[id]
            # Kinds push doesn't manage (MCP...) stay attached by id, as agents.pull leaves them.
            tool.nil? || !managed?(tool) ? @tool_ids << id : @tools << tool
          end
        end
        load_system_tools(base)
        @raw_workflow = workflow if workflow.is_a?(::Hash)
      end

      # System tools become SystemTool objects, so replacing +tools+ replaces them like on an agent built in
      # code.
      def load_system_tools(base)
        built_in = AgentWire.get_path(base, BUILT_IN_TOOLS_PATH)
        return unless built_in.is_a?(::Hash)

        built_in.dup.each_key do |key|
          raw = built_in[key]
          next unless raw.is_a?(::Hash)

          tool = begin
            AgentTools::Tool.from_json(SYSTEM_TYPE.merge(raw))
          rescue StandardError
            next # Kept in the config as it is.
          end
          next unless tool.kind == 'system' && tool.as_system.system_tool_type == key

          @tools << tool
          @loaded_system[tool] = [raw, safe_json(tool)]
          built_in.delete(key)
        end
        AgentWire.delete_path(base, BUILT_IN_TOOLS_PATH) if built_in.empty?
      end

      def workflow_tools
        return @workflow.tools unless @workflow.nil?

        AgentWire.raw_workflow_tool_ids(@raw_workflow).filter_map { |id| @tools_by_id[id] }
      end

      # Builds the API-format config. Without +tool_ids+ (validation only), tools stand under placeholder ids
      # and missing ids aren't reported.
      def assemble(tool_ids, on_warning)
        issues = []
        config = AgentWire.deep_copy(@base)
        id_of = ->(tool) { (tool_ids || {})[tool.name] || "<tool:#{tool.name}>" }

        issues << AgentIssue.error('missing_name', nil, 'The agent needs a name') if @name.to_s.strip.empty?

        # Raw options first, so the typed ones win and can be checked against them.
        raw = {}
        @raw_conversation_config.each do |settings|
          AgentWire.deep_merge(raw, 'conversation_config' => raw_wire(settings, ::Elevenlabs::Types::ConversationalConfig))
        rescue StandardError => e
          issues << invalid_config('conversation_config', e)
        end
        @raw_platform_settings.each do |settings|
          AgentWire.deep_merge(raw, 'platform_settings' => raw_wire(settings, ::Elevenlabs::Types::AgentPlatformSettingsRequestModel))
        rescue StandardError => e
          issues << invalid_config('platform_settings', e)
        end
        AgentWire.deep_merge(config, raw)

        @typed.each do |key, value|
          path = TYPED_OPTIONS[key]
          issues << conflict(key, path) if AgentWire.path?(raw, path)
          AgentWire.set_path(config, path, AgentWire.value(value))
        end

        check_tools(issues)
        set_tools(config, raw, issues, id_of)
        set_workflow(config, issues, tool_ids, id_of)

        unless tool_ids.nil?
          tools.each do |tool|
            next if tool_ids.key?(tool.name)

            issues << AgentIssue.error('unresolved_tool', "tools.#{tool.name}",
                                       "Tool \"#{tool.name}\" has no id yet. Push the agent with agents.push, or pass tool_ids")
          end
        end

        unless AgentWire.get_path(config, PROMPT_PATH).is_a?(::String)
          issues << AgentIssue.new(code: 'missing_prompt', severity: 'warning', message: 'The agent needs a prompt',
                                   path: PROMPT_PATH.join('.'))
        end

        unique = issues.uniq { |issue| [issue.code, issue.path, issue.message] }
        errors = unique.select { |issue| issue.severity == 'error' }
        raise AgentValidationError.new(@name, errors) unless errors.empty?

        unique.each { |warning| on_warning.call(warning) if warning.severity == 'warning' } unless on_warning.nil?

        config['name'] = @name
        config['conversation_config'] = {} if config['conversation_config'].nil?
        config['platform_settings'] = {} if config['platform_settings'].nil?
        config['tags'] = @tags.nil? ? [] : @tags.dup
        AgentWire.canonical(config)
      end

      # Every tool validates, and no two different tools share a name.
      def check_tools(issues)
        by_name = {}
        (@tools + workflow_tools).each do |tool|
          other = by_name[tool.name]
          issues << AgentIssue.error('duplicate_tool_name', "tools.#{tool.name}", "Two different tools are named \"#{tool.name}\"") unless other.nil? || other.equal?(tool)
          next unless other.nil?

          by_name[tool.name] = tool
          begin
            tool.build_config
          rescue StandardError => e
            issues << AgentIssue.error('invalid_tool', "tools.#{tool.name}", e.message)
          end
          check_attached(tool, issues)
        end
      end

      # A tool of another kind (such as MCP) isn't created or updated by agents.push, so it needs the id the agent
      # was loaded with to stay attached.
      def check_attached(tool, issues)
        return if tool.kind == 'system' || managed?(tool) || !known_id(tool).nil?

        type = begin
          tool.to_json['type']
        rescue StandardError
          nil
        end
        issues << AgentIssue.error('invalid_tool', "tools.#{tool.name}",
                                   "Tool \"#{tool.name}\" has type \"#{type}\", which push doesn't create or update: " \
                                   'load it with its id or attach it with tool_ids')
      end

      # Webhook and client tools: the ones agents.push creates or updates.
      def managed?(tool)
        %w[webhook client].include?(tool.kind)
      end

      # The id the agent was loaded with for +tool+, matched by identity.
      def known_id(tool)
        @tools_by_id.each { |id, loaded| return id if loaded.equal?(tool) }
        nil
      end

      # A tool's id in the config: a managed tool's from +id_of+, any other's the id it was loaded with.
      def attached_id(tool, id_of)
        managed?(tool) ? id_of.call(tool) : known_id(tool) || "<tool:#{tool.name}>"
      end

      def set_tools(config, raw, issues, id_of)
        attached = []
        @tools.reject { |tool| tool.kind == 'system' }.each do |tool|
          id = attached_id(tool, id_of)
          # A tool of another kind (MCP...) added back while its id is still in tool_ids is attached once.
          next if !managed?(tool) && (@tool_ids.include?(id) || attached.include?(id))

          attached << id
        end
        if @tool_list_given
          issues << conflict('tools', TOOL_IDS_PATH) if AgentWire.path?(raw, TOOL_IDS_PATH)
          AgentWire.set_path(config, TOOL_IDS_PATH, keep_order(@tool_ids + attached, @loaded_tool_ids))
        end
        @tools.select { |tool| tool.kind == 'system' }.each do |system_tool|
          path = BUILT_IN_TOOLS_PATH + [system_tool.as_system.system_tool_type]
          issues << conflict('tools', path) if AgentWire.path?(raw, path)
          loaded = @loaded_system[system_tool]
          if !loaded.nil? && !loaded[1].nil? && safe_json(system_tool) == loaded[1]
            AgentWire.set_path(config, path, AgentWire.deep_copy(loaded[0]))
            next
          end
          begin
            AgentWire.set_path(config, path, system_tool.to_json)
          rescue StandardError
            nil # Reported as invalid_tool.
          end
        end
      end

      # The workflow: its own checks, plus tool nodes can only run webhook and client tools.
      def set_workflow(config, issues, tool_ids, id_of)
        if !@workflow.nil?
          wf = @workflow
          wf.tools.select { |tool| tool.kind == 'system' }.each do |tool|
            issues << AgentIssue.error('system_tool_in_workflow', "workflow.tools.#{tool.name}",
                                       "System tool \"#{tool.name}\" can't be used in a workflow node; add it to the agent's tools")
          end
          ids = wf.tools.to_h { |tool| [tool.name, attached_id(tool, id_of)] }
          begin
            config['workflow'] = wf.to_json(tool_ids: ids)
          rescue StandardError => e
            issues << AgentIssue.error('invalid_workflow', 'workflow', e.message)
          end
        elsif !@raw_workflow.nil?
          # Check the loaded graph without replacing the raw copy, which keeps fields this SDK doesn't model.
          begin
            AgentWorkflows::Workflow.from_json(@raw_workflow).build
          rescue StandardError => e
            issues << AgentIssue.error('invalid_workflow', 'workflow', e.message)
          end
          # Its managed tools may have new ids, e.g. when pushed as a new agent.
          config['workflow'] = AgentWire.map_raw_workflow_tool_ids(AgentWire.deep_copy(@raw_workflow)) do |id|
            tool = @tools_by_id[id]
            tool.nil? || tool_ids.nil? || !managed?(tool) ? id : tool_ids.fetch(tool.name, id)
          end
        end
      end

      # A raw conversation_config or platform_settings option in wire format. Hashes are checked against
      # +model+'s declared field types.
      def raw_wire(settings, model)
        if settings.is_a?(::Elevenlabs::Internal::Types::Model)
          wire = AgentWorkflows::Wire.to_wire(settings)
        elsif settings.is_a?(::Hash)
          wire = AgentWire.value(settings)
          ConfigCheck.check!(model, wire)
        else
          raise ArgumentError, "expected #{model.name.split('::').last} or a Hash, not #{settings.class}"
        end
        wire
      end

      def safe_json(tool)
        tool.to_json_string
      rescue StandardError
        nil
      end

      # +ids+ with the ones in +loaded+ first, in that order, then the rest as they are.
      def keep_order(ids, loaded)
        ids.each_with_index.sort_by { |id, i| [loaded.index(id) || loaded.length, i] }.map(&:first)
      end

      def invalid_config(option, err)
        AgentIssue.error('invalid_config', option, "Invalid #{option}: #{err.message}")
      end

      def conflict(option, path)
        dotted = path.join('.')
        AgentIssue.error('option_conflict', dotted, "\"#{option}\" and the raw config both set #{dotted}; set it in one place")
      end
    end
  end
end
