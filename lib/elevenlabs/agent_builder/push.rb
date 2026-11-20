# frozen_string_literal: true

require_relative 'agent'
require_relative 'errors'
require_relative 'wire'

module Elevenlabs
  module AgentBuilder
    # The steps of agents.push and agents.pull, on the generated agents and tools clients. See
    # AgentsClientPush for what each does.
    #
    # @api private
    module Push
      # The tool kinds tools.json lists and push manages.
      MANAGED_KINDS = %w[webhook client].freeze

      module_function

      def push(agents, tools_client, agent, agent_id:, project:, branch_id:, version_description:, request_options:)
        raise ArgumentError, "Pass agent_id or project to agents.push, not both: the project records the agent's id" if !project.nil? && !agent_id.nil?

        agent.validate
        project&.check_branch(agent, branch_id)

        tools = agent.tools
        agent_id = project.agent_id(agent) unless project.nil?
        result = PartialAgentPushResult.new
        ids = {}
        step = "Couldn't read the agent's tools"
        begin
          # The tools the agent already uses. With a project they're matched by recorded id; without one, by
          # name among the tools this agent uses, so a same-named tool another agent uses is never touched.
          in_use = if agent_id.nil?
                     []
                   elsif branch_id.nil?
                     list_tools_used_by(tools_client, agent_id, request_options)
                   else
                     tools_on_branch(agents, tools_client, agent_id, branch_id, request_options)
                   end
          used_by_name = in_use.to_h { |remote| [tool_name(remote), remote] }

          tools.each do |tool|
            known_id = project.nil? ? used_by_name[tool.name]&.id : project.tool_id(tool)
            remote = nil
            unless known_id.nil?
              step = "Couldn't read tool \"#{tool.name}\" (#{known_id})"
              remote = in_use.find { |t| t.id == known_id } ||
                       tools_client.get(tool_id: known_id, request_options: request_options)
            end
            config = project&.unchanged_raw(tool) || tool.to_json
            if !remote.nil? && same_tool?(remote, tool, config)
              ids[tool.name] = remote.id
              result.tools[tool.name] = ToolPushResult.new(id: remote.id, action: 'unchanged')
              # The server already matches, but the project may hold an older definition: bring it up to date.
              project&.record_tool(tool, remote.id, config)
              next
            end
            # The generated client drops fields it doesn't model, so the wire config is sent as the body.
            options = with_body(request_options, 'tool_config' => config)
            if remote.nil?
              step = "Couldn't create tool \"#{tool.name}\""
              created = tools_client.create(tool_config: config, request_options: options)
              ids[tool.name] = created.id
              result.tools[tool.name] = ToolPushResult.new(id: created.id, action: 'created')
            else
              step = "Couldn't update tool \"#{tool.name}\" (#{remote.id})"
              tools_client.update(tool_id: remote.id, tool_config: config, request_options: options)
              ids[tool.name] = remote.id
              result.tools[tool.name] = ToolPushResult.new(id: remote.id, action: 'updated')
            end
            project&.record_tool(tool, ids[tool.name], config)
          end

          # The typed body goes through the generated client; the API-format config, sent as extra body
          # parameters, replaces its top-level fields, so settings this SDK doesn't model reach the API too.
          config = agent.to_json(tool_ids: ids)

          # Every id the new config still uses, wherever it is: the agent's tool_ids and the workflow's nodes.
          kept = AgentWire.tool_ids_in(config)
          in_use.each do |remote|
            name = tool_name(remote)
            next if kept.include?(remote.id) || result.tools.key?(name)

            result.tools[name] = ToolPushResult.new(id: remote.id, action: 'detached')
          end

          typed = agent.build(tool_ids: ids).to_h.transform_keys(&:to_sym)
          options = with_body(request_options, config)
          version_id = nil
          if agent_id.nil?
            step = "Couldn't create agent \"#{agent.name}\""
            new_id = agents.create(**typed, request_options: options).agent_id
            action = 'created'
          else
            step = "Couldn't update agent \"#{agent.name}\" (#{agent_id})"
            extra = {}
            extra[:branch_id] = branch_id unless branch_id.nil?
            extra[:version_description] = version_description unless version_description.nil?
            updated = agents.update(agent_id: agent_id, **typed, **extra, request_options: options)
            version_id = updated.version_id
            new_id = agent_id
            action = 'updated'
          end
          result.agent_id = new_id
          result.action = action
          project&.record_agent(agent, new_id, config, branch_id: branch_id, version_id: version_id)
        rescue StandardError => e
          save_quietly(project)
          raise AgentPushError.new(step, result, e)
        end
        project.save if !project.nil? && !project.dir.nil?
        AgentPushResult.new(agent_id: new_id, action: action, tools: result.tools)
      end

      def pull(agents, tools_client, agent_id, project:, branch_id:, request_options:)
        project&.check_branch_by_id(agent_id, branch_id)
        query = branch_id.nil? ? {} : { branch_id: branch_id }
        response = agents.get(agent_id: agent_id, **query, request_options: request_options)
        live = AgentWire.response_wire(response)
        # The CLI's pulled-config shape: these keys only, so ids and server metadata stay out of the file.
        config = {
          'name' => live['name'],
          'conversation_config' => live['conversation_config'] || {},
          'platform_settings' => live['platform_settings'] || {},
          'tags' => live['tags'] || [],
        }
        config['workflow'] = live['workflow'] if live['workflow'].is_a?(::Hash)

        tools_by_id = {}
        tool_configs = {}
        AgentWire.tool_ids_in(config).each do |id|
          remote = tools_client.get(tool_id: id, request_options: request_options)
          wire = AgentTools::ToolWire.parse(remote.tool_config)
          tool = AgentTools::Tool.from_json(wire)
          # tools.json lists webhook and client tools; others (MCP...) stay attached by id.
          next unless MANAGED_KINDS.include?(tool.kind)

          tools_by_id[id] = tool
          tool_configs[id] = AgentWire.canonical(wire)
        end

        agent = Agent.from_json(config, tools_by_id: tools_by_id)
        unless project.nil?
          tools_by_id.each { |id, tool| project.record_tool(tool, id, tool_configs[id], match_by: :id) }
          project.record_agent(agent, agent_id, config, branch_id: branch_id, version_id: response.version_id, match_by: :id)
          project.save unless project.dir.nil?
        end
        agent
      end

      def list_tools_used_by(tools_client, agent_id, request_options)
        all = []
        cursor = nil
        loop do
          page_query = { used_by_agent_id: agent_id, page_size: 100 }
          page_query[:cursor] = cursor unless cursor.nil?
          page = tools_client.list(**page_query, request_options: request_options)
          all.concat(page.tools.to_a)
          cursor = page.has_more ? page.next_cursor : nil
          break if cursor.nil? || cursor.to_s.empty?
        end
        all
      end

      # The tools a branch of the agent uses. The tools API's used_by_agent_id covers the main branch only, so
      # they come from the branch's config, by id.
      def tools_on_branch(agents, tools_client, agent_id, branch_id, request_options)
        branch = agents.get(agent_id: agent_id, branch_id: branch_id, request_options: request_options)
        AgentWire.tool_ids_in(AgentWire.response_wire(branch)).map do |id|
          tools_client.get(tool_id: id, request_options: request_options)
        end
      end

      def tool_name(remote)
        name = AgentWire.response_wire(remote.tool_config)
        name = name['name'] if name.is_a?(::Hash)
        name.is_a?(::String) ? name : remote.id
      end

      # Whether the server already has this tool as defined. Modeled fields are compared through the builder,
      # so both sides normalize alike; the config to send must also be contained in the server's, so a change
      # to a field the builder doesn't model still counts.
      def same_tool?(remote, tool, config)
        AgentTools::Tool.from_response(remote).to_json_string == tool.to_json_string &&
          AgentWire.subset?(config, AgentTools::ToolWire.parse(remote.tool_config))
      rescue StandardError
        false
      end

      def with_body(request_options, body)
        (request_options || {}).to_h.merge(additional_body_parameters: body)
      end

      def save_quietly(project)
        return if project.nil? || project.dir.nil?

        project.save
      rescue StandardError
        nil # The push error is the one to report; the ids it carries are in the raised result.
      end
    end

    # agents.push and agents.pull for agents written as code, added to the generated agents client
    # (+client.agents+) when +elevenlabs/agent_builder+ is required.
    module AgentsClientPush
      # Creates or updates an agent and every webhook and client tool it uses, in one call.
      #
      # 1. Validates the agent, so an invalid one writes nothing.
      # 2. Creates each tool that's new and updates each one that changed. Which tools already exist comes
      #    from the project's tools.json, or, without a project, from the tools the agent (+agent_id+) already
      #    uses, by name: on its main branch, or on +branch_id+ when given. Tools other agents use are never
      #    touched.
      # 3. Creates the agent, or updates it, with the tools' ids filled in.
      #
      # Settings the SDK doesn't model, kept from a loaded config, are sent too. Tools the agent stops using
      # are reported as "detached", not deleted.
      #
      # @param agent [Elevenlabs::AgentBuilder::Agent] The agent to push.
      # @param agent_id [String, nil] The agent to update. Without it (and without a project that knows the
      #   agent), push creates a new agent, so keep the returned +agent_id+. Not allowed with +project+, which
      #   records the id itself.
      # @param project [Elevenlabs::AgentBuilder::AgentProject, nil] A project in the CLI's layout. Its
      #   agents.json and tools.json say which agent and tools on the server this definition is; push records
      #   new ids there and writes the configs it sent, saving them if the project was opened from a directory.
      # @param branch_id [String, nil] Update this branch of the agent instead of its main branch.
      # @param version_description [String, nil] Describes the new version, for agents with versioning.
      # @param request_options [Hash] Passed to every API call push makes.
      # @return [Elevenlabs::AgentBuilder::AgentPushResult] The agent's id, whether it was created or updated,
      #   and what happened to each tool.
      # @raise [Elevenlabs::AgentBuilder::AgentValidationError] If the agent is invalid, before any API call.
      # @raise [Elevenlabs::AgentBuilder::AgentPushError] If an API call fails, with what was already written
      #   in +result+.
      #
      #   result = client.agents.push(agent)
      #   client.agents.push(agent, agent_id: result.agent_id)   # later: update it
      #   client.agents.push(agent, project: project)            # or let a project track the ids
      def push(agent, agent_id: nil, project: nil, branch_id: nil, version_description: nil, request_options: {})
        Push.push(self, tools, agent, agent_id: agent_id, project: project, branch_id: branch_id,
                                      version_description: version_description, request_options: request_options)
      end

      # Loads an existing agent as an Agent, with its webhook and client tools as Tool objects. With a
      # project, also writes the agent and its tools there, in the CLI's layout, and records their ids.
      #
      # @param agent_id [String] The agent to load.
      # @param project [Elevenlabs::AgentBuilder::AgentProject, nil] Writes the agent and its tools into this
      #   project, and records their ids.
      # @param branch_id [String, nil] Pull this branch instead of the main one.
      # @param request_options [Hash] Passed to every API call pull makes.
      # @return [Elevenlabs::AgentBuilder::Agent]
      #
      #   agent = client.agents.pull(agent_id, project: project)
      #   agent.update(first_message: 'Hello!')
      #   client.agents.push(agent, project: project)
      def pull(agent_id, project: nil, branch_id: nil, request_options: {})
        Push.pull(self, tools, agent_id, project: project, branch_id: branch_id, request_options: request_options)
      end
    end

    ::Elevenlabs::Agents::Client.prepend(AgentsClientPush)
  end
end
