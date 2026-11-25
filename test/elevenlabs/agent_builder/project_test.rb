# frozen_string_literal: true

require 'minitest/autorun'
require 'json'
require 'tmpdir'
require 'fileutils'
require_relative 'fake_server'

module Elevenlabs
  module AgentBuilder
    # Each case checks one project load or write end to end, so it asserts on the files, ids and changes together.
    module ProjectSupport
      Tool = ::Elevenlabs::AgentTools::Tool
      # A project in the CLI's layout, shared by every SDK and copied from the reference SDK (elevenlabs-js,
      # docs/agents-as-code/fixtures); see agent-spec.md there, "Fixtures".
      CLI_PROJECT = File.join(__dir__, 'fixtures', 'project', 'cli-graph')

      def read_tree(dir)
        paths = Dir.glob('**/*', File::FNM_DOTMATCH, base: dir).sort.select { |path| File.file?(File.join(dir, path)) }
        paths.to_h { |path| [path, File.binread(File.join(dir, path)).force_encoding('UTF-8')] }
      end

      def read_json(path)
        JSON.parse(File.read(File.join(CLI_PROJECT, path)))
      end
    end

    # The fixture checks every SDK must pass (agent-spec.md, "Fixtures").
    class ProjectFixtureTest < Minitest::Test
      include ProjectSupport

      def test_loads_the_cli_project_with_the_same_agents_tools_ids_and_attached_ids
        project = AgentProject.from_files(read_tree(CLI_PROJECT))

        assert_equal %w[Support Billing], project.agents.map(&:name)
        assert_equal %w[lookup_order issue_refund], project.tools.map(&:name)

        support = project.agent('Support')

        assert_equal ['lookup_order'], support.tools.map(&:name)
        assert_equal ['tool_from_dashboard'], support.tool_ids
        assert_equal 'agent_support', project.agent_id(support)
        assert_equal 'tool_lookup', project.tool_id(support.tools[0])
        assert_same project.tools[0], support.tools[0]

        billing = project.agent('Billing')

        assert_equal 'agent_billing', project.agent_id(billing)
        assert_equal ['issue_refund'], billing.tools.map(&:name)
        assert_empty billing.tool_ids
        assert_equal 'tool_refund', project.tool_id(project.tools[1])
        assert_same billing, project.agent('Billing')
      end

      def test_gives_back_every_file_byte_identical_when_nothing_was_pushed_branch_configs_included
        files = read_tree(CLI_PROJECT)

        assert_equal files, AgentProject.from_files(files).to_files
        assert_includes files, 'agent_configs/support.beta.json'
      end

      def test_round_trips_the_cli_agent_config_to_its_sorted_form
        support = AgentProject.from_files(read_tree(CLI_PROJECT)).agent('Support')
        config = support.to_json(tool_ids: { 'lookup_order' => 'tool_lookup' })

        assert_equal ProjectFormat.format_config(read_json('agent_configs/support.json')), ProjectFormat.format_config(config)
      end
    end

    class ProjectTest < Minitest::Test
      include ProjectSupport

      def index(config)
        JSON.generate('agents' => [{ 'config' => config }])
      end

      def test_reports_missing_malformed_and_not_yet_supported_files_clearly
        error = assert_raises(AgentProjectError) { AgentProject.from_files('agents.json' => index('agent_configs/a.yaml')) }

        assert_match(/only JSON config files are supported yet/, error.message)
        error = assert_raises(AgentProjectError) { AgentProject.from_files('agents.json' => index('agent_configs/a.toml')) }

        assert_match(%r{agent_configs/a\.toml}, error.message)
        error = assert_raises(AgentProjectError) { AgentProject.from_files('agents.json' => index('agent_configs/a.json')) }

        assert_match(%r{points at agent_configs/a\.json, which doesn't exist}, error.message)
        assert_raises(AgentProjectError) { AgentProject.from_files('agents.json' => '{') }
        assert_raises(AgentProjectError) { AgentProject.from_files('agents.json' => '{"agents": {}}') }
        error = assert_raises(AgentProjectError) { AgentProject.from_files({}).agent('Nope') }

        assert_match(/No agent named "Nope"/, error.message)
      end

      def test_writes_index_and_config_files_in_the_cli_format
        assert_equal "{\n    \"a\": [\n        1,\n        {}\n    ],\n    \"b\": []\n}", ProjectFormat.format_index('a' => [1, {}], 'b' => [])
        assert_equal "{\n    \"a\": 1.5,\n    \"b\": {\n        \"c\": 2,\n        \"d\": \"é\"\n    }\n}",
                     ProjectFormat.format_config('b' => { 'd' => 'é', 'c' => 2.0 }, 'a' => 1.5)
      end

      def test_names_new_files_like_the_cli
        assert_equal 'Support-line-EU', ProjectFormat.sanitize_filename('  Support line / EU ')
        assert_equal '_hidden', ProjectFormat.sanitize_filename('.hidden')
        assert_equal 'unnamed', ProjectFormat.sanitize_filename('...')
        assert_equal 'unnamed', ProjectFormat.sanitize_filename('   ')
        assert_equal 'a-b', ProjectFormat.sanitize_filename('a:*?"<>|b')
        assert_equal 'a' * 100, ProjectFormat.sanitize_filename('a' * 120)
        assert_equal 'agent_configs/A-2.json', ProjectFormat.unique_path('agent_configs', 'A', %w[agent_configs/A.json agent_configs/A-1.json])
      end

      def test_save_needs_a_directory
        error = assert_raises(AgentProjectError) { AgentProject.from_files({}).save }

        assert_match(/to_files/, error.message)
      end

      def test_keeps_the_main_agent_when_a_branch_is_recorded_and_the_tool_type
        project = AgentProject.from_files(read_tree(CLI_PROJECT))
        main = project.agent('Support')
        beta = Agent.from_json(read_json('agent_configs/support.beta.json'))
        project.record_agent(beta, 'agent_support', beta.to_json, branch_id: 'agtbrch_beta', match_by: :id)

        assert_same main, project.agent('Support')
        assert_includes project.changed_files, 'agent_configs/support.beta.json'
        refute_includes project.changed_files, 'agent_configs/support.json'

        lookup = project.tools[0]
        client_tool = Tool.client('lookup_order', 'Now a client tool')
        project.record_tool(client_tool, project.tool_id(lookup), client_tool.to_json, match_by: :id)

        assert_equal 'client', JSON.parse(project.to_files['tools.json'])['tools'][0]['type']
      end

      def test_drops_a_pending_write_once_a_file_is_back_to_what_was_loaded
        loaded = { 'name' => 'A', 'conversation_config' => {}, 'platform_settings' => {}, 'tags' => [] }
        files = {
          'agents.json' => ProjectFormat.format_index('agents' => [{ 'config' => 'agent_configs/a.json', 'id' => 'agent_1' }]),
          'agent_configs/a.json' => ProjectFormat.format_config(loaded),
        }
        project = AgentProject.from_files(files)
        agent = project.agent('A')
        project.record_agent(agent, 'agent_1', loaded.merge('tags' => ['x']))

        assert_equal ['agent_configs/a.json'], project.changed_files
        project.record_agent(agent, 'agent_1', loaded)

        assert_empty project.changed_files
        assert_equal files.merge('tools.json' => "{\n    \"tools\": []\n}"), project.to_files
      end

      def test_matches_a_rebuilt_agent_by_name_and_rejects_ambiguous_names
        project = AgentProject.from_files(read_tree(CLI_PROJECT))

        assert_equal 'agent_billing', project.agent_id(Agent.new('Billing'))
        duplicate = AgentProject.from_files(
          'agents.json' => ProjectFormat.format_index('agents' => [{ 'config' => 'agent_configs/a.json' }, { 'config' => 'agent_configs/b.json' }]),
          'agent_configs/a.json' => JSON.generate('name' => 'A'),
          'agent_configs/b.json' => JSON.generate('name' => 'A'),
        )
        error = assert_raises(AgentProjectError) { duplicate.agent_id(Agent.new('A')) }

        assert_match(/are named/, error.message)
      end

      def test_new_files_skip_names_already_taken
        project = AgentProject.from_files({})
        project.record_agent(Agent.new('A', prompt: 'p'), 'agent_1', Agent.new('A', prompt: 'p').to_json)
        project.record_agent(Agent.new('B', prompt: 'p'), 'agent_2', Agent.new('B', prompt: 'p').to_json)
        other = Agent.new('A', prompt: 'q')
        project.record_agent(other, 'agent_3', other.to_json, match_by: :id)

        assert_equal(%w[agent_configs/A.json agent_configs/B.json agent_configs/A-1.json],
                     JSON.parse(project.to_files['agents.json'])['agents'].map { |entry| entry['config'] })
      end
    end

    class ProjectOnDiskTest < Minitest::Test
      include ProjectSupport

      def test_opens_an_empty_directory_and_push_writes_the_cli_layout_owner_only
        Dir.mktmpdir do |dir|
          FileUtils.mkdir_p(File.join(dir, 'agent_configs'))
          File.write(File.join(dir, 'agent_configs', 'A.json'), 'not ours') # a file the project doesn't list
          project = AgentProject.open(dir)
          server = FakeServer.new
          agent = Agent.new('A', prompt: 'p', tools: [Tool.client('ping', 'Ping the app')])

          server.client.agents.push(agent, project: project)

          files = read_tree(dir)

          assert_equal %w[agent_configs/A-1.json agent_configs/A.json agents.json tool_configs/ping.json tools.json], files.keys.sort
          assert_equal 'not ours', files['agent_configs/A.json']
          assert_equal "{\n    \"description\": \"Ping the app\",\n    \"name\": \"ping\",\n    \"type\": \"client\"\n}", files['tool_configs/ping.json']
          %w[agents.json tools.json agent_configs/A-1.json tool_configs/ping.json].each do |path|
            assert_equal 0o600, File.stat(File.join(dir, path)).mode & 0o777, path
          end
          assert_empty project.changed_files

          reopened = AgentProject.open(dir)

          assert_equal project.agent_id(agent), reopened.agent_id(reopened.agent('A'))
          assert_equal read_tree(dir).except('agent_configs/A.json'), reopened.to_files
        end
      end

      def test_gives_back_the_fixture_byte_identical_when_opened_from_disk
        Dir.mktmpdir do |dir|
          FileUtils.cp_r(File.join(CLI_PROJECT, '.'), dir)

          assert_equal read_tree(CLI_PROJECT), AgentProject.open(dir).to_files
        end
      end

      def test_keeps_line_endings_of_files_it_did_not_change
        Dir.mktmpdir do |dir|
          text = "{\r\n    \"agents\": []\r\n}"
          File.binwrite(File.join(dir, 'agents.json'), text)

          assert_equal text, AgentProject.open(dir).to_files['agents.json']
        end
      end

      def test_refuses_config_paths_outside_the_project_directly_or_through_a_symlink
        Dir.mktmpdir do |tmp|
          outside = File.join(tmp, 'outside')
          FileUtils.mkdir_p(outside)
          File.write(File.join(outside, 'a.json'), '{}')

          escaping = File.join(tmp, 'escaping')
          FileUtils.mkdir_p(escaping)
          File.write(File.join(escaping, 'agents.json'), JSON.generate('agents' => [{ 'config' => '../outside/a.json' }]))
          error = assert_raises(AgentProjectError) { AgentProject.open(escaping) }

          assert_match(/outside the project/, error.message)

          linked = File.join(tmp, 'linked')
          FileUtils.mkdir_p(linked)
          File.symlink(outside, File.join(linked, 'agent_configs'))
          File.write(File.join(linked, 'agents.json'), JSON.generate('agents' => [{ 'config' => 'agent_configs/a.json' }]))
          error = assert_raises(AgentProjectError) { AgentProject.open(linked) }

          assert_match(/through a symlink/, error.message)
        end
      end

      def test_never_writes_through_a_symlinked_file
        Dir.mktmpdir do |tmp|
          target = File.join(tmp, 'elsewhere.json')
          File.write(target, 'keep')
          project_dir = File.join(tmp, 'project')
          FileUtils.mkdir_p(project_dir)
          project = AgentProject.open(project_dir)
          File.symlink(target, File.join(project_dir, 'agents.json'))
          project.record_agent(Agent.new('A', prompt: 'p'), 'agent_1', Agent.new('A', prompt: 'p').to_json)

          assert_raises(AgentProjectError) { project.save }
          assert_equal 'keep', File.read(target)
        end
      end

      def test_never_writes_a_new_file_through_a_symlinked_directory
        Dir.mktmpdir do |tmp|
          outside = File.join(tmp, 'outside')
          FileUtils.mkdir_p(outside)
          project_dir = File.join(tmp, 'project')
          FileUtils.mkdir_p(project_dir)
          project = AgentProject.open(project_dir)
          File.symlink(outside, File.join(project_dir, 'agent_configs'))
          project.record_agent(Agent.new('A', prompt: 'p'), 'agent_1', Agent.new('A', prompt: 'p').to_json)

          assert_raises(AgentProjectError) { project.save }
          assert_empty Dir.children(outside)
        end
      end
    end
  end
end
