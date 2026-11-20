# frozen_string_literal: true

require 'minitest/autorun'
require 'json'
require 'elevenlabs'
require 'elevenlabs/agent_builder'

module Elevenlabs
  module AgentBuilder
    # Several cases check one assembled config end to end, so they assert on its parts together.
    # rubocop:disable Minitest/MultipleAssertions
    class AgentTest < Minitest::Test
      Tool = ::Elevenlabs::AgentTools::Tool
      Schema = ::Elevenlabs::AgentTools::Schema
      SystemTool = ::Elevenlabs::AgentTools::SystemTool
      Workflow = ::Elevenlabs::AgentWorkflows::Workflow
      CLI_PROJECT = File.join(__dir__, 'fixtures', 'project', 'cli-graph')

      def read_json(path)
        JSON.parse(File.read(File.join(CLI_PROJECT, path)))
      end

      def get_order
        Tool.webhook('get_order', 'Look up an order by its number')
            .get('https://api.example.com/orders/{order_id}')
            .path_param('order_id', Schema.string.describe('The order number'))
      end

      def show_order
        Tool.client('show_order', 'Show the order card').param('order_id', Schema.string.from_variable('order_id'))
      end

      def issues_of
        yield

        flunk 'expected an AgentValidationError'
      rescue AgentValidationError => e
        e.issues.map { |issue| [issue.code, issue.path] }
      end

      def test_maps_typed_options_tools_and_system_tools_into_the_api_config
        agent = Agent.new(
          'Support line',
          prompt: 'You are a support agent.', first_message: 'Hi!', language: 'en', llm: :'gemini-2.0-flash',
          temperature: 0.5, voice_id: 'voice_1', tts_model: 'eleven_flash_v2_5', tags: ['support'],
          tools: [SystemTool.end_call, get_order], tool_ids: ['tool_existing']
        )
        config = agent.to_json(tool_ids: { 'get_order' => 'tool_1' })

        assert_equal(
          {
            'conversation_config' => {
              'agent' => {
                'first_message' => 'Hi!',
                'language' => 'en',
                'prompt' => {
                  'built_in_tools' => {
                    'end_call' => { 'name' => 'end_call', 'params' => { 'system_tool_type' => 'end_call' }, 'type' => 'system' },
                  },
                  'llm' => 'gemini-2.0-flash',
                  'prompt' => 'You are a support agent.',
                  'temperature' => 0.5,
                  'tool_ids' => %w[tool_existing tool_1],
                },
              },
              'tts' => { 'model_id' => 'eleven_flash_v2_5', 'voice_id' => 'voice_1' },
            },
            'name' => 'Support line',
            'platform_settings' => {},
            'tags' => ['support'],
          },
          config,
        )
        assert_equal JSON.generate(AgentWire.canonical(config)), JSON.generate(config)

        body = agent.build(tool_ids: { get_order: 'tool_1' })

        assert_equal 'Support line', body.name
        assert_equal %w[tool_existing tool_1], body.conversation_config.agent.prompt.tool_ids
        assert_nil body.workflow
      end

      def test_typed_option_paths_are_fields_the_generated_models_declare
        Agent::TYPED_OPTIONS.each do |option, path|
          type = ::Elevenlabs::Agents::Types::BodyCreateAgentV1ConvaiAgentsCreatePost
          path.each do |step|
            field = type.fields.values.find { |f| f.api_name.to_s == step }

            refute_nil field, "#{option}: #{type} has no field #{step}"
            type = ::Elevenlabs::Internal::Types::Utils.unwrap_type(field.type)
          end
        end
      end

      def test_merges_the_raw_config_under_the_typed_options
        agent = Agent.new(
          'A', prompt: 'p',
               conversation_config: { 'turn' => { 'turn_timeout' => 7 }, agent: { disable_first_message_interruptions: true } },
               platform_settings: { 'privacy' => { 'record_voice' => false } }
        )
        agent.update(conversation_config: ::Elevenlabs::Types::ConversationalConfig.new(turn: { silence_end_call_timeout: 20 }))
        config = agent.to_json

        assert_equal(
          {
            'agent' => { 'disable_first_message_interruptions' => true, 'prompt' => { 'prompt' => 'p' } },
            'turn' => { 'silence_end_call_timeout' => 20, 'turn_timeout' => 7 },
          },
          config['conversation_config'],
        )
        assert_equal({ 'privacy' => { 'record_voice' => false } }, config['platform_settings'])
      end

      def test_reports_a_raw_config_the_generated_model_rejects
        agent = Agent.new('A', prompt: 'p', conversation_config: { 'turn' => { 'turn_timeout' => 'soon' } })

        assert_equal([%w[invalid_config conversation_config]], issues_of { agent.validate })
        assert_equal([%w[invalid_config platform_settings]], issues_of { Agent.new('A', prompt: 'p', platform_settings: 'x').validate })
      end

      def test_fills_in_the_ids_of_tool_objects_used_by_workflow_nodes
        lookup = get_order
        show = show_order
        wf = Workflow.new
        wf.converse('triage', 'Find out what the caller needs')
          .when('Caller gave an order number')
          .tool('lookup', [lookup], schema_overrides: { 'get_order' => { 'path_params.order_id' => { 'source' => 'constant', 'constant_value' => '1' } } })
          .on_success
          .converse('resolve', 'Explain the order', tool_ids: [show, 'tool_raw'])
        agent = Agent.new('A', prompt: 'p', workflow: wf)

        assert_equal [lookup, show], agent.tools
        nodes = agent.to_json(tool_ids: { 'get_order' => 'tool_g', 'show_order' => 'tool_s' })['workflow']['nodes']

        assert_equal(
          [{ 'schema_overrides' => { 'path_params.order_id' => { 'constant_value' => '1', 'source' => 'constant' } }, 'tool_id' => 'tool_g' }],
          nodes['lookup']['tools'],
        )
        assert_equal %w[tool_s tool_raw], nodes['resolve']['additional_tool_ids']
        assert_equal([%w[unresolved_tool tools.show_order]], issues_of { agent.to_json(tool_ids: { 'get_order' => 'tool_g' }) })
      end

      def test_validates_without_ids_so_ci_needs_no_api_key
        assert_nil Agent.new('A', prompt: 'p', tools: [get_order]).validate
      end

      def test_reports_every_problem_at_once
        wf = Workflow.new
        wf.tool('hang_up', [SystemTool.end_call])
        agent = Agent.new(
          '', prompt: 'p',
              tools: [get_order, get_order, Tool.webhook('broken', 'No URL')],
              workflow: wf,
              conversation_config: { 'agent' => { 'prompt' => { 'prompt' => 'raw prompt' } } }
        )

        assert_equal(
          [
            ['missing_name', nil],
            %w[option_conflict conversation_config.agent.prompt.prompt],
            %w[duplicate_tool_name tools.get_order],
            %w[invalid_tool tools.broken],
            %w[system_tool_in_workflow workflow.tools.end_call],
          ],
          issues_of { agent.validate },
        )
      end

      def test_the_same_tool_object_twice_is_fine
        tool = get_order
        wf = Workflow.new
        wf.tool('lookup', [tool])

        assert_nil Agent.new('A', prompt: 'p', tools: [tool], workflow: wf).validate
      end

      def test_reports_a_system_tool_the_raw_config_also_sets
        agent = Agent.new('A', prompt: 'p', tools: [SystemTool.end_call],
                               conversation_config: { 'agent' => { 'prompt' => { 'built_in_tools' => { 'end_call' => {} } } } })

        assert_equal([%w[option_conflict conversation_config.agent.prompt.built_in_tools.end_call]], issues_of { agent.validate })
      end

      def test_warns_without_failing_when_there_is_no_prompt
        warnings = []
        Agent.new('A').validate(on_warning: ->(issue) { warnings << issue.code })

        assert_equal ['missing_prompt'], warnings
      end

      def test_round_trips_a_cli_agent_config_keeping_unmodeled_fields_and_tool_order
        raw = read_json('agent_configs/support.json')
        lookup = Tool.from_json(read_json('tool_configs/lookup_order.json'))
        agent = Agent.from_json(raw, tools_by_id: { 'tool_lookup' => lookup })

        assert_equal 'Support', agent.name
        assert_equal [lookup], agent.tools
        assert_equal ['tool_from_dashboard'], agent.tool_ids
        assert_equal JSON.generate(AgentWire.canonical(raw)), JSON.generate(agent.to_json(tool_ids: { 'lookup_order' => 'tool_lookup' }))
      end

      def test_turns_a_loaded_workflow_into_a_workflow_on_first_use_with_tool_objects
        raw = read_json('agent_configs/support.beta.json')
        refund = Tool.from_json(read_json('tool_configs/issue_refund.json'))
        agent = Agent.from_json(raw, tools_by_id: { 'tool_refund' => refund })

        assert_equal [refund], agent.tools # read from the raw workflow, before it's materialized
        assert_equal AgentWire.canonical(raw['workflow']), agent.to_json(tool_ids: { 'issue_refund' => 'tool_refund' })['workflow']

        agent.workflow.node('refunds').update(prompt: 'Handle refunds')
        nodes = agent.to_json(tool_ids: { 'issue_refund' => 'tool_new' })['workflow']['nodes']

        assert_equal ['tool_new'], nodes['refunds']['additional_tool_ids']
        assert_equal 'Handle refunds', nodes['refunds']['additional_prompt']
        assert_equal [refund], agent.workflow.tools
      end

      def test_writes_new_tool_ids_into_a_loaded_workflow_it_has_not_materialized
        refund = Tool.from_json(read_json('tool_configs/issue_refund.json'))
        agent = Agent.from_json(read_json('agent_configs/support.beta.json'), tools_by_id: { 'tool_refund' => refund })

        assert_equal ['tool_clone'], agent.to_json(tool_ids: { 'issue_refund' => 'tool_clone' })['workflow']['nodes']['refunds']['additional_tool_ids']
      end

      def test_validates_a_loaded_workflow_without_materializing_it
        raw = read_json('agent_configs/support.beta.json')
        raw['workflow']['edges']['broken'] = { 'source' => 'start_node', 'target' => 'nowhere' }

        assert_equal([%w[invalid_workflow workflow]], issues_of { Agent.from_json(raw).validate })
      end

      def test_accepts_a_json_string
        text = File.read(File.join(CLI_PROJECT, 'agent_configs', 'billing.json'))

        # Fields the file leaves out get their defaults, like platform_settings: {}.
        assert_equal AgentWire.canonical(JSON.parse(text).merge('platform_settings' => {})), Agent.from_json(text).to_json
      end

      def test_replaces_a_loaded_agents_system_tools_along_with_its_other_tools
        agent = Agent.from_json(read_json('agent_configs/support.json'))

        assert_empty agent.tools # system tools aren't managed by push
        agent.update(tools: [])
        prompt = agent.to_json['conversation_config']['agent']['prompt']

        refute_includes prompt, 'built_in_tools'
        assert_equal %w[tool_lookup tool_from_dashboard], prompt['tool_ids'] # ids it doesn't manage stay
      end

      def test_treats_an_explicitly_empty_tool_list_as_set
        agent = Agent.new('A', prompt: 'p', tool_ids: [], conversation_config: { 'agent' => { 'prompt' => { 'tool_ids' => ['tool_existing'] } } })

        assert_equal([%w[option_conflict conversation_config.agent.prompt.tool_ids]], issues_of { agent.validate })
      end

      def test_attaches_a_tool_added_with_add_tool_and_update_replaces_options
        agent = Agent.new('A', prompt: 'p').add_tool(get_order)

        assert_equal ['tool_1'], agent.to_json(tool_ids: { 'get_order' => 'tool_1' }).dig('conversation_config', 'agent', 'prompt', 'tool_ids')

        agent.update(name: 'B', prompt: 'q', tags: ['x'])
        config = agent.to_json(tool_ids: { 'get_order' => 'tool_1' })

        assert_equal 'B', agent.name
        assert_equal 'q', config.dig('conversation_config', 'agent', 'prompt', 'prompt')
        assert_equal ['x'], config['tags']
      end

      def test_deep_merge_copies_what_it_merges
        source = { 'turn' => { 'turn_timeout' => 7 }, 'tags' => ['a'] }
        target = { 'turn' => {} }
        AgentWire.deep_merge(target, source)
        source['turn']['turn_timeout'] = 8
        source['tags'] << 'b'

        assert_equal({ 'turn' => { 'turn_timeout' => 7 }, 'tags' => ['a'] }, target)
      end
    end
    # rubocop:enable Minitest/MultipleAssertions
  end
end
