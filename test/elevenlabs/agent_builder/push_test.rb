# frozen_string_literal: true

require 'minitest/autorun'
require 'json'
require 'tmpdir'
require_relative 'fake_server'

module Elevenlabs
  module AgentBuilder
    # Each case checks one push or pull end to end, so it asserts on the result, the requests and the project together.
    # rubocop:disable Minitest/MultipleAssertions
    # agents.push and agents.pull against FakeServer, through the generated client.
    module PushSupport
      Tool = ::Elevenlabs::AgentTools::Tool
      Schema = ::Elevenlabs::AgentTools::Schema
      SystemTool = ::Elevenlabs::AgentTools::SystemTool
      Workflow = ::Elevenlabs::AgentWorkflows::Workflow

      def get_order(description = 'Look up an order by its number')
        Tool.webhook('get_order', description)
            .get('https://api.example.com/orders/{order_id}')
            .path_param('order_id', Schema.string.describe('The order number'))
      end

      def show_order
        Tool.client('show_order', 'Show the order card').param('order_id', Schema.string.from_variable('order_id'))
      end

      def support_agent(tools = [get_order, show_order])
        wf = Workflow.new
        wf.converse('triage', 'Find out what the caller needs')
          .when('Caller gave an order number')
          .tool('lookup', [tools[0]])
          .on_success
          .converse('resolve', 'Explain the order')
        Agent.new('Support line', prompt: 'You help with orders.', tools: [SystemTool.end_call, *tools[1..]], workflow: wf)
      end

      def fixture_files
        dir = File.join(__dir__, 'fixtures', 'project', 'cli-graph')
        paths = Dir.glob('**/*', base: dir).select { |path| File.file?(File.join(dir, path)) }
        paths.to_h { |path| [path, File.binread(File.join(dir, path)).force_encoding('UTF-8')] }
      end

      def dumps(value)
        JSON.pretty_generate(value, indent: '    ')
      end
    end

    class PushTest < Minitest::Test
      include PushSupport

      def test_creates_the_tools_then_the_agent_with_their_ids
        server = FakeServer.new
        result = server.client.agents.push(support_agent)

        assert_equal ['POST /v1/convai/tools', 'POST /v1/convai/tools', 'POST /v1/convai/agents/create'], server.writes
        assert_equal 'agent_new_3', result.agent_id
        assert_equal 'created', result.action
        assert_equal(
          [
            ['show_order', ToolPushResult.new(id: 'tool_new_1', action: 'created')],
            ['get_order', ToolPushResult.new(id: 'tool_new_2', action: 'created')],
          ],
          result.tools.to_a,
        )
        sent = server.agents['agent_new_3']

        assert_equal ['tool_new_1'], sent.dig('conversation_config', 'agent', 'prompt', 'tool_ids')
        assert_equal 'end_call', sent.dig('conversation_config', 'agent', 'prompt', 'built_in_tools', 'end_call', 'name')
        assert_equal [{ 'tool_id' => 'tool_new_2' }], sent.dig('workflow', 'nodes', 'lookup', 'tools')
        assert_equal 'Support line', sent['name']
        assert_equal server.tools['tool_new_2']['config'], get_order.to_json
      end

      def test_updates_only_what_changed_and_leaves_another_agents_same_named_tool_alone
        server = FakeServer.new
        client = server.client
        agent_id = client.agents.push(support_agent).agent_id
        server.add_tool('tool_other', get_order("Someone else's").to_json, ['agent_other'])
        server.calls.clear

        again = client.agents.push(support_agent([get_order('Find an order'), show_order]), agent_id: agent_id)

        assert_equal ['PATCH /v1/convai/tools/tool_new_2', "PATCH /v1/convai/agents/#{agent_id}"], server.writes
        assert_equal({ 'used_by_agent_id' => agent_id, 'page_size' => '100' }, server.calls[0].query)
        assert_equal(
          {
            'show_order' => ToolPushResult.new(id: 'tool_new_1', action: 'unchanged'),
            'get_order' => ToolPushResult.new(id: 'tool_new_2', action: 'updated'),
          },
          again.tools,
        )
        assert_equal 'updated', again.action
        assert_equal "Someone else's", server.tools['tool_other']['config']['description']
      end

      def test_matches_by_name_only_among_the_agents_own_tools
        server = FakeServer.new
        # A same-named tool only another agent uses: never matched, so a new one is created.
        server.add_tool('tool_other', get_order.to_json, ['agent_other'])
        server.add_agent('agent_1', {})

        result = server.client.agents.push(support_agent, agent_id: 'agent_1')

        assert_equal 'created', result.tools['get_order'].action
        refute_equal 'tool_other', result.tools['get_order'].id
      end

      def test_follows_the_tools_list_cursor
        server = FakeServer.new
        client = server.client
        agent_id = client.agents.push(support_agent).agent_id
        server.calls.clear
        # The first page is empty and points at a second; the fake server answers that one with every tool.
        WebMock::API.stub_request(:get, "#{FakeServer::BASE}/v1/convai/tools")
                    .with(query: { 'used_by_agent_id' => agent_id, 'page_size' => '100' })
                    .to_return(status: 200, body: JSON.generate('tools' => [], 'has_more' => true, 'next_cursor' => 'c2'),
                               headers: { 'Content-Type' => 'application/json' })

        result = client.agents.push(support_agent, agent_id: agent_id)

        assert_equal({ 'used_by_agent_id' => agent_id, 'page_size' => '100', 'cursor' => 'c2' }, server.calls[0].query)
        assert_equal(%w[unchanged unchanged], result.tools.values.map(&:action))
      end

      def test_reports_tools_the_agent_stopped_using_as_detached_without_deleting_them
        server = FakeServer.new
        client = server.client
        agent_id = client.agents.push(support_agent).agent_id
        agent = support_agent
        agent.update(tools: [])

        result = client.agents.push(agent, agent_id: agent_id)

        assert_equal ToolPushResult.new(id: 'tool_new_1', action: 'detached'), result.tools['show_order']
        assert_includes server.tools, 'tool_new_1'
        refute(server.calls.any? { |call| call.verb == 'DELETE' })
      end

      def test_does_not_report_a_tool_as_detached_while_the_workflow_still_uses_its_id
        server = FakeServer.new
        client = server.client
        server.add_tool('tool_raw', show_order.to_json)
        wf = Workflow.new
        wf.tool('run', ['tool_raw'])
        agent = Agent.new('A', prompt: 'p', workflow: wf)
        agent_id = client.agents.push(agent).agent_id

        assert_empty client.agents.push(agent, agent_id: agent_id).tools
      end

      def test_validates_before_any_api_call
        server = FakeServer.new
        agent = Agent.new('A', prompt: 'p', tools: [Tool.webhook('broken', 'No URL')])

        assert_raises(AgentValidationError) { server.client.agents.push(agent) }
        assert_empty server.calls
      end

      def test_reports_what_it_wrote_before_a_failure
        server = FakeServer.new
        server.fail_on = %r{\APOST /v1/convai/agents/create\z}

        error = assert_raises(AgentPushError) { server.client.agents.push(support_agent) }

        assert error.message.start_with?('Couldn\'t create agent "Support line"')
        assert_equal 'Couldn\'t create agent "Support line"', error.step
        assert_kind_of ::Elevenlabs::Errors::ResponseError, error.cause
        assert_equal(
          {
            'show_order' => ToolPushResult.new(id: 'tool_new_1', action: 'created'),
            'get_order' => ToolPushResult.new(id: 'tool_new_2', action: 'created'),
          },
          error.result.tools,
        )
        assert_nil error.result.agent_id
        assert_nil error.result.action
      end

      def test_names_the_tool_whose_request_failed
        server = FakeServer.new
        server.fail_on = %r{\APOST /v1/convai/tools\z}

        error = assert_raises(AgentPushError) { server.client.agents.push(support_agent) }

        assert_equal 'Couldn\'t create tool "show_order"', error.step
        assert_empty error.result.tools
      end

      def test_refuses_agent_id_together_with_a_project
        server = FakeServer.new
        error = assert_raises(ArgumentError) do
          server.client.agents.push(support_agent, agent_id: 'agent_1', project: AgentProject.from_files({}))
        end

        assert_match(/not both/, error.message)
        assert_empty server.calls
      end

      def test_sends_version_description_and_branch_only_when_given
        server = FakeServer.new
        client = server.client
        agent_id = client.agents.push(support_agent).agent_id
        server.calls.clear
        client.agents.push(support_agent, agent_id: agent_id)
        patch = server.calls.find { |call| call.verb == 'PATCH' }

        refute_includes patch.body, 'version_description'
        assert_empty patch.query

        server.calls.clear
        server.branches[[agent_id, 'agtbrch_1']] = JSON.parse(JSON.generate(server.agents[agent_id]))
        client.agents.push(support_agent, agent_id: agent_id, branch_id: 'agtbrch_1', version_description: 'v2')
        patch = server.calls.find { |call| call.verb == 'PATCH' }

        assert_equal 'v2', patch.body['version_description']
        assert_equal({ 'branch_id' => 'agtbrch_1' }, patch.query)
      end

      def test_matches_a_branch_push_against_the_branch_tools_not_the_main_branch
        server = FakeServer.new
        client = server.client
        agent_id = client.agents.push(support_agent).agent_id
        # The branch uses its own copy of get_order, and no show_order.
        server.add_tool('tool_branch_order', get_order('Branch lookup').to_json)
        branch = JSON.parse(JSON.generate(server.agents[agent_id]))
        branch['workflow']['nodes']['lookup']['tools'] = [{ 'tool_id' => 'tool_branch_order' }]
        branch['conversation_config']['agent']['prompt']['tool_ids'] = []
        server.branches[[agent_id, 'agtbrch_1']] = branch
        server.calls.clear

        result = client.agents.push(support_agent([get_order('Changed lookup')]), agent_id: agent_id, branch_id: 'agtbrch_1')

        assert_equal ToolPushResult.new(id: 'tool_branch_order', action: 'updated'), result.tools['get_order']
        refute_includes result.tools, 'show_order' # a main-branch tool the branch never used isn't "detached"
        assert_equal ['PATCH /v1/convai/tools/tool_branch_order', "PATCH /v1/convai/agents/#{agent_id}"], server.writes
        assert(server.calls.none? { |call| call.query.key?('used_by_agent_id') })
        assert_equal({ 'branch_id' => 'agtbrch_1' }, server.calls[0].query)
      end

      def test_build_is_the_generated_create_request
        body = support_agent.build(tool_ids: { 'get_order' => 'tool_g', 'show_order' => 'tool_s' })

        assert_kind_of ::Elevenlabs::Agents::Types::BodyCreateAgentV1ConvaiAgentsCreatePost, body
        assert_equal ['tool_s'], body.conversation_config.agent.prompt.tool_ids
        assert_equal 'Support line', body.name
      end
    end

    class PushWithAProjectTest < Minitest::Test
      include PushSupport

      def test_records_ids_and_writes_the_cli_layout_then_updates_by_recorded_id
        server = FakeServer.new
        client = server.client
        project = AgentProject.from_files({})

        client.agents.push(support_agent, project: project)
        files = project.to_files

        assert_equal(
          %w[agent_configs/Support-line.json agents.json tool_configs/get_order.json tool_configs/show_order.json tools.json],
          files.keys.sort,
        )
        assert_equal(
          "{\n    \"agents\": [\n        {\n            \"config\": \"agent_configs/Support-line.json\",\n            " \
          "\"id\": \"agent_new_3\"\n        }\n    ]\n}",
          files['agents.json'],
        )
        assert_equal(
          {
            'tools' => [
              { 'type' => 'client', 'config' => 'tool_configs/show_order.json', 'id' => 'tool_new_1' },
              { 'type' => 'webhook', 'config' => 'tool_configs/get_order.json', 'id' => 'tool_new_2' },
            ],
          },
          JSON.parse(files['tools.json']),
        )
        config = JSON.parse(files['agent_configs/Support-line.json'])

        assert_equal ['tool_new_1'], config.dig('conversation_config', 'agent', 'prompt', 'tool_ids')
        assert_equal ProjectFormat.format_config(get_order.to_json), files['tool_configs/get_order.json']

        # A fresh script run: new objects, matched to the project's entries by name.
        server.calls.clear
        reloaded = AgentProject.from_files(files)
        result = client.agents.push(support_agent, project: reloaded)

        assert_equal ['PATCH /v1/convai/agents/agent_new_3'], server.writes
        assert_equal 'unchanged', result.tools['get_order'].action
        # Only the version the update reported is new, recorded like the CLI does.
        assert_equal ['agents.json'], reloaded.changed_files
        assert_equal 'ver_1', JSON.parse(reloaded.to_files['agents.json'])['agents'][0]['version_id']
      end

      def test_pushes_a_loaded_agents_settings_the_sdk_does_not_model
        server = FakeServer.new
        client = server.client
        server.add_tool('tool_lookup', { 'type' => 'client', 'name' => 'lookup', 'description' => 'old' })
        project = AgentProject.from_files(
          'agents.json' => JSON.generate('agents' => [{ 'config' => 'agent_configs/a.json', 'id' => 'agent_1' }]),
          'tools.json' => JSON.generate('tools' => [{ 'type' => 'client', 'config' => 'tool_configs/t.json', 'id' => 'tool_lookup' }]),
          'agent_configs/a.json' => JSON.generate(
            'name' => 'A',
            'conversation_config' => {
              'agent' => { 'prompt' => { 'prompt' => 'p', 'tool_ids' => ['tool_lookup'] } },
              'future_setting' => { 'on' => true },
            },
            'platform_settings' => {},
            'tags' => [],
          ),
          'tool_configs/t.json' => JSON.generate('type' => 'client', 'name' => 'lookup', 'description' => 'd', 'future_field' => 1),
        )
        server.add_agent('agent_1', {})

        agent = project.agent('A')
        agent.update(first_message: 'Hello')
        client.agents.push(agent, project: project)

        tool_patch = server.calls.find { |c| c.verb == 'PATCH' && c.path.include?('/tools/') }

        assert_equal 1, tool_patch.body['tool_config']['future_field']
        agent_patch = server.calls.find { |c| c.verb == 'PATCH' && c.path.include?('/agents/') }

        assert_equal({ 'on' => true }, agent_patch.body['conversation_config']['future_setting'])
        assert_equal 'Hello', agent_patch.body['conversation_config']['agent']['first_message']
        assert_equal %w[agent_configs/a.json agents.json tool_configs/t.json tools.json], project.changed_files.sort
      end

      def test_tools_the_server_adds_fields_to_still_count_as_unchanged
        server = FakeServer.new
        client = server.client
        agent_id = client.agents.push(support_agent).agent_id
        # The API's copy carries fields the builder doesn't model, at the top level and nested, plus nulls.
        config = server.tools['tool_new_2']['config']
        config['server_only'] = 'x'
        config['assignments'] = nil
        config['api_schema']['server_nested'] = { 'a' => 1 }
        server.calls.clear

        again = client.agents.push(support_agent, agent_id: agent_id)

        assert_equal ["PATCH /v1/convai/agents/#{agent_id}"], server.writes
        assert_equal 'unchanged', again.tools['get_order'].action
        assert_equal 'x', server.tools['tool_new_2']['config']['server_only']
      end

      def test_updates_a_project_tool_whose_only_change_is_a_field_the_sdk_does_not_model
        server = FakeServer.new
        server.add_tool('tool_1', { 'type' => 'client', 'name' => 'ping', 'description' => 'd', 'future_field' => 1 }, ['agent_1'])
        server.add_agent('agent_1', {})
        project = AgentProject.from_files(
          'agents.json' => JSON.generate('agents' => [{ 'config' => 'agent_configs/a.json', 'id' => 'agent_1' }]),
          'tools.json' => JSON.generate('tools' => [{ 'type' => 'client', 'config' => 'tool_configs/t.json', 'id' => 'tool_1' }]),
          'agent_configs/a.json' => JSON.generate('name' => 'A', 'conversation_config' => { 'agent' => { 'prompt' => { 'prompt' => 'p', 'tool_ids' => ['tool_1'] } } }),
          'tool_configs/t.json' => JSON.generate('type' => 'client', 'name' => 'ping', 'description' => 'd', 'future_field' => 2),
        )

        result = server.client.agents.push(project.agent('A'), project: project)

        assert_equal 'updated', result.tools['ping'].action
        assert_equal 2, server.tools['tool_1']['config']['future_field']
      end

      def test_brings_the_project_up_to_date_when_the_server_already_matches_a_new_definition
        server = FakeServer.new
        client = server.client
        project = AgentProject.from_files({})
        client.agents.push(support_agent([get_order('v2'), show_order]), project: project)
        stale = AgentProject.from_files(project.to_files.merge('tool_configs/get_order.json' => dumps(get_order('v1').to_json)))

        result = client.agents.push(support_agent([get_order('v2'), show_order]), project: stale)

        assert_equal 'unchanged', result.tools['get_order'].action
        assert_equal 'v2', JSON.parse(stale.to_files['tool_configs/get_order.json'])['description']
      end

      def test_saves_what_it_wrote_to_a_project_directory_when_a_request_fails
        Dir.mktmpdir do |dir|
          server = FakeServer.new
          server.fail_on = %r{\APOST /v1/convai/agents/create\z}
          project = AgentProject.open(dir)

          error = assert_raises(AgentPushError) { server.client.agents.push(support_agent, project: project) }

          assert_equal %w[get_order show_order], error.result.tools.keys.sort
          reopened = AgentProject.open(dir)

          assert_equal(%w[tool_new_1 tool_new_2], reopened.tools.map { |tool| reopened.tool_id(tool) })
          assert_empty reopened.agents
          assert_empty project.changed_files
        end
      end

      def test_pushes_a_branch_into_its_own_file
        server = FakeServer.new
        client = server.client
        files = fixture_files
        project = AgentProject.from_files(files)
        server.add_tool('tool_lookup', JSON.parse(files['tool_configs/lookup_order.json']))
        server.add_tool('tool_refund', JSON.parse(files['tool_configs/issue_refund.json']))
        server.branches[%w[agent_support agtbrch_beta]] = JSON.parse(files['agent_configs/support.beta.json'])
        beta = Agent.from_json(files['agent_configs/support.beta.json'],
                               tools_by_id: project.tools.to_h { |tool| [project.tool_id(tool), tool] })
        beta.update(prompt: 'Beta prompt')

        result = client.agents.push(beta, project: project, branch_id: 'agtbrch_beta')

        assert_equal 'updated', result.action
        # tools.json is rewritten in the CLI's format (the fixture's is hand-formatted); support.json isn't touched.
        assert_equal %w[agent_configs/support.beta.json agents.json tools.json], project.changed_files.sort
        assert_equal 'Beta prompt', JSON.parse(project.to_files['agent_configs/support.beta.json']).dig('conversation_config', 'agent', 'prompt', 'prompt')
        entry = JSON.parse(project.to_files['agents.json'])['agents'][0]

        assert_equal 'ver_1', entry['branches']['beta']['version_id']
        refute_includes entry, 'version_id'
        assert_equal files['agent_configs/support.json'], project.to_files['agent_configs/support.json']
      end

      def test_rejects_a_branch_the_project_has_no_file_for_before_any_request
        files = fixture_files
        project = AgentProject.from_files(files)
        server = FakeServer.new
        client = server.client

        assert_raises(AgentProjectError) { client.agents.push(project.agent('Billing'), project: project, branch_id: 'agtbrch_x') }
        error = assert_raises(AgentProjectError) { client.agents.pull('agent_support', project: project, branch_id: 'agtbrch_x') }

        assert_match(/has no config file/, error.message)
        assert_empty server.calls
      end
    end

    class PullTest < Minitest::Test
      include PushSupport

      def test_loads_an_agent_with_its_tools_as_tool_objects_and_writes_them_into_a_project
        server = FakeServer.new
        client = server.client
        agent_id = client.agents.push(support_agent).agent_id

        project = AgentProject.from_files({})
        agent = client.agents.pull(agent_id, project: project)

        assert_equal 'Support line', agent.name
        assert_equal %w[show_order get_order], agent.tools.map(&:name)
        assert_equal agent_id, project.agent_id(agent)

        files = project.to_files

        assert_equal(
          %w[agent_configs/Support-line.json agents.json tool_configs/get_order.json tool_configs/show_order.json tools.json],
          files.keys.sort,
        )
        config = JSON.parse(files['agent_configs/Support-line.json'])

        assert_equal %w[conversation_config name platform_settings tags workflow], config.keys
        assert_equal 'ver_1', JSON.parse(files['agents.json'])['agents'][0]['version_id']

        # Pushing the pulled agent back changes no tools.
        server.calls.clear
        result = client.agents.push(agent, project: project)

        assert_equal ["PATCH /v1/convai/agents/#{agent_id}"], server.writes
        assert_equal %w[unchanged unchanged], result.tools.values.map(&:action)
      end

      def test_pulls_a_branch_and_keeps_other_tool_kinds_attached_by_id
        server = FakeServer.new
        server.add_tool('tool_mcp', { 'type' => 'mcp', 'name' => 'search', 'description' => 'MCP search' })
        server.add_tool('tool_show', show_order.to_json)
        server.branches[%w[agent_1 agtbrch_1]] = {
          'name' => 'A',
          'conversation_config' => { 'agent' => { 'prompt' => { 'prompt' => 'p', 'tool_ids' => %w[tool_mcp tool_show] } } },
        }

        agent = server.client.agents.pull('agent_1', branch_id: 'agtbrch_1')

        assert_equal({ 'branch_id' => 'agtbrch_1' }, server.calls[0].query)
        assert_equal ['show_order'], agent.tools.map(&:name)
        assert_equal ['tool_mcp'], agent.tool_ids
      end
    end
    # rubocop:enable Minitest/MultipleAssertions
  end
end
