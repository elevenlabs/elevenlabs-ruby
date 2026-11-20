# frozen_string_literal: true

require 'json'
require_relative 'agent'
require_relative 'errors'
require_relative 'format'
require_relative 'project_files'

module Elevenlabs
  module AgentBuilder
    # An agents-as-code project in the ElevenLabs CLI's layout: agents.json and tools.json list the agents and
    # tools with their ids, and each one's config sits in agent_configs/ or tool_configs/ in API format. A
    # project made by +elevenlabs agents init+ / +pull+ works here, and one written here works with the CLI.
    #
    # Pass it to +client.agents.push(agent, project: project)+ and +client.agents.pull(agent_id, project:
    # project)+: the project records which agent and tools on the server each definition is, so pushing again
    # updates them instead of making copies.
    #
    #   project = Elevenlabs::AgentBuilder::AgentProject.open('.')
    #   agent = project.agent('Support line')
    #   agent.update(prompt: '...')
    #   client.agents.push(agent, project: project)
    class AgentProject
      AGENTS_FILE = ProjectFiles::AGENTS_FILE
      TOOLS_FILE = ProjectFiles::TOOLS_FILE
      AGENT_CONFIGS_DIR = ProjectFiles::AGENT_CONFIGS_DIR
      TOOL_CONFIGS_DIR = ProjectFiles::TOOL_CONFIGS_DIR

      # Entry fields in the order the CLI writes them. Unset fields are left out.
      AGENT_ENTRY_FIELDS = %w[config id branch_id version_id branches].freeze
      TOOL_ENTRY_FIELDS = %w[type config id].freeze

      # One entry in agents.json, and the agent loaded from it.
      AgentSlot = Struct.new(:entry, :agent)
      # One entry in tools.json and its tool. +raw+ is the config as loaded, in API format, sent as it is
      # while the tool is unchanged so fields this SDK doesn't model survive; +baseline+ is the tool's
      # to_json_string as loaded, to tell whether it was edited since.
      ToolSlot = Struct.new(:entry, :tool, :raw, :baseline)
      private_constant :AgentSlot, :ToolSlot

      # The directory the project was opened from, if any. save writes there.
      attr_reader :dir

      # @api private — use from_files or open.
      def initialize(files, dir = nil, taken = [])
        @dir = dir
        @files = files.to_h { |path, text| [ProjectFormat.normalize_path(path), text] }
        @agents = []
        @tools = []
        # Paths written since loading, with their new contents.
        @changed = {}
        # Paths in use on disk, so new files don't overwrite one the project doesn't list.
        @taken = (@files.keys + taken.map { |path| ProjectFormat.normalize_path(path) }).to_h { |path| [path, true] }
        load_project
      end

      class << self
        # A project from file contents, keyed by path relative to the project root. No I/O. Only agents.json,
        # tools.json and the config files they list are read. Missing index files mean an empty project.
        def from_files(files)
          new(files)
        end

        # Reads the project in +dir+. A directory without agents.json and tools.json opens as an empty
        # project, and save creates them.
        def open(dir)
          files, taken = ProjectFiles.read_project(dir)
          new(files, dir.to_s, taken)
        end
      end

      # Every agent in the project, in agents.json order.
      def agents
        @agents.map(&:agent)
      end

      # The agent named +name+. The same object every time, so edits to it are what +agents.push(agent,
      # project: project)+ sends. Raises AgentProjectError if no agent, or more than one, has that name.
      def agent(name)
        matches = @agents.select { |slot| slot.agent.name == name }
        return matches.first.agent if matches.length == 1

        raise AgentProjectError, (matches.empty? ? "No agent named \"#{name}\" in #{AGENTS_FILE}" : "#{matches.length} agents in #{AGENTS_FILE} are named \"#{name}\"")
      end

      # Every tool in tools.json, in order.
      def tools
        @tools.map(&:tool)
      end

      # The id agents.json records for this agent, if it was pushed or pulled.
      def agent_id(agent)
        agent_slot(agent)&.entry&.[]('id')
      end

      # The id tools.json records for this tool, if it was pushed or pulled.
      def tool_id(tool)
        tool_slot(tool)&.entry&.[]('id')
      end

      # The project's files, keyed by path: the index files and every config they list, branch configs
      # included, with what push and pull wrote since loading. Files nothing changed keep their exact text.
      def to_files
        files = {
          AGENTS_FILE => @changed[AGENTS_FILE] || @files[AGENTS_FILE] || agents_index,
          TOOLS_FILE => @changed[TOOLS_FILE] || @files[TOOLS_FILE] || tools_index,
        }
        paths = @agents.map { |slot| slot.entry['config'] } +
                @agents.flat_map { |slot| branch_entries(slot).filter_map { |branch| branch['config'] if branch['config'].is_a?(::String) } } +
                @tools.map { |slot| slot.entry['config'] }
        paths.each do |path|
          key = ProjectFormat.normalize_path(path)
          text = @changed.key?(key) ? @changed[key] : @files[key]
          files[path] = text unless text.nil?
        end
        files
      end

      # The paths push and pull changed since the project was loaded or last saved.
      def changed_files
        @changed.keys
      end

      # Writes the files push and pull changed to the project's directory, owner-only, and returns their
      # paths. agents.push and agents.pull call this themselves for a project opened with open.
      def save
        raise AgentProjectError, "This project wasn't opened from a directory; use to_files instead" if @dir.nil?

        written = @changed.to_a
        return [] if written.empty?

        ProjectFiles.write_project_files(@dir, written)
        written.each { |path, text| @files[path] = text }
        @changed.clear
        written.map(&:first)
      end

      # @api private — used by agents.push. The loaded config to send for a tool whose definition matches its project entry (the loaded object, or
      # one rebuilt in code with the same name), so fields this SDK doesn't model survive.
      def unchanged_raw(tool)
        slot = tool_slot(tool)
        return nil if slot.nil? || slot.raw.nil? || slot.baseline.nil?

        safe_json(tool) == slot.baseline ? slot.raw : nil
      end

      # @api private — used by agents.push and agents.pull. Records a tool's id and the config now on the server, adding an entry if it's new. Push finds the
      # entry by definition (+match_by: :definition+); pull, by id.
      def record_tool(tool, id, config, match_by: :definition)
        slot = match_by == :id ? @tools.find { |s| s.entry['id'] == id } : tool_slot(tool)
        if slot.nil?
          path = new_path(TOOL_CONFIGS_DIR, tool.name)
          slot = ToolSlot.new({ 'type' => tool.kind, 'config' => path }, tool, nil, nil)
          @tools << slot
        end
        slot.tool = tool
        slot.entry['id'] = id
        slot.entry['type'] = tool.kind
        slot.raw = config
        slot.baseline = safe_json(tool)
        write(slot.entry['config'], ProjectFormat.format_config(config))
        write(TOOLS_FILE, tools_index)
      end

      # @api private — used by agents.push and agents.pull. Records an agent's id and its config, adding an entry if it's new. Push matches like record_tool. A
      # branch's config goes to that branch's file, and its version on the branch entry.
      def record_agent(agent, id, config, branch_id: nil, version_id: nil, match_by: :definition)
        slot = match_by == :id ? @agents.find { |s| s.entry['id'] == id } : agent_slot(agent)
        if slot.nil?
          slot = AgentSlot.new({ 'config' => new_path(AGENT_CONFIGS_DIR, agent.name) }, agent)
          @agents << slot
        end
        slot.entry['id'] = id
        branch = branch_id.nil? ? nil : branch_entries(slot).find { |b| b['branch_id'] == branch_id }
        # A branch has its own file; the slot's agent is the main branch's, which a branch must not replace.
        slot.agent = agent if branch.nil?
        # Like the CLI: the version the server reports, on the entry it belongs to.
        (branch || slot.entry)['version_id'] = version_id unless version_id.nil?
        # check_branch ran first, so a branch has its own config path; it never writes the main branch's file.
        write(branch.nil? ? slot.entry['config'] : branch['config'], ProjectFormat.format_config(config))
        write(AGENTS_FILE, agents_index)
      end

      # @api private — used by agents.push. Rejects a branch the project has no file for, before anything is written: its settings would
      # otherwise land in the main branch's file, and a later CLI push would send them to the main branch.
      def check_branch(agent, branch_id)
        check_branch_of(agent_slot(agent), agent.name, branch_id) unless branch_id.nil?
      end

      # @api private — check_branch for agents.pull, which finds the agent by id.
      def check_branch_by_id(agent_id, branch_id)
        check_branch_of(@agents.find { |s| s.entry['id'] == agent_id }, agent_id, branch_id) unless branch_id.nil?
      end

      private

      # The entry for an agent: the one it was loaded from, else the only one with its name.
      def agent_slot(agent)
        @agents.find { |slot| slot.agent.equal?(agent) } ||
          single(@agents.select { |slot| slot.agent.name == agent.name }, AGENTS_FILE, agent.name)
      end

      # The entry for a tool: the one it was loaded from, else the only one with its name.
      def tool_slot(tool)
        @tools.find { |slot| slot.tool.equal?(tool) } ||
          single(@tools.select { |slot| slot.tool.name == tool.name }, TOOLS_FILE, tool.name)
      end

      def single(matches, index, name)
        raise AgentProjectError, "#{matches.length} entries in #{index} are named \"#{name}\"; push the loaded one" if matches.length > 1

        matches.first
      end

      def check_branch_of(slot, label, branch_id)
        return if !slot.nil? && slot.entry['branch_id'] == branch_id
        branch = slot.nil? ? nil : branch_entries(slot).find { |b| b['branch_id'] == branch_id }
        return if branch.is_a?(::Hash) && branch['config'].is_a?(::String) && !branch['config'].empty?

        raise AgentProjectError, "Branch #{branch_id} of \"#{label}\" has no config file in #{AGENTS_FILE}. Add it under " \
                                 "\"branches\" (the CLI's `agents pull --all-branches` does), or push the main branch"
      end

      def branch_entries(slot)
        branches = slot.entry['branches']
        branches.is_a?(::Hash) ? branches.values.grep(::Hash) : []
      end

      def new_path(dir, name)
        path = ProjectFormat.unique_path(dir, name, @taken)
        @taken[path] = true
        path
      end

      def write(path, text)
        key = ProjectFormat.normalize_path(path)
        if @files[key] == text
          @changed.delete(key)
        else
          @changed[key] = text
        end
      end

      def load_project
        agents_index = read_index(AGENTS_FILE, 'agents')
        tools_index = read_index(TOOLS_FILE, 'tools')

        by_id = {}
        tools_index.each do |entry|
          raw = read_config(entry['config'], TOOLS_FILE)
          tool = begin
            AgentTools::Tool.from_json(raw)
          rescue StandardError => e
            raise AgentProjectError, "#{entry['config']} isn't a valid tool config: #{e.message}"
          end
          @tools << ToolSlot.new(entry.dup, tool, raw, safe_json(tool))
          by_id[entry['id']] = tool if entry['id'].is_a?(::String)
        end
        agents_index.each do |entry|
          raw = read_config(entry['config'], AGENTS_FILE)
          @agents << AgentSlot.new(entry.dup, Agent.from_json(raw, tools_by_id: by_id))
        end
      end

      def read_index(path, key)
        text = @files[path]
        return [] if text.nil?

        parsed = parse_json(text, path)
        entries = parsed.is_a?(::Hash) ? parsed[key] : nil
        return [] if entries.nil?
        raise AgentProjectError, "#{path} must hold a \"#{key}\" list of entries" unless entries.is_a?(::Array) && entries.all?(::Hash)

        entries
      end

      def read_config(path, index)
        raise AgentProjectError, "#{index} has an entry without a \"config\" path" unless path.is_a?(::String)
        raise AgentProjectError, "#{index} points at #{path}: only JSON config files are supported yet (YAML and TOML aren't)" unless path.match?(/\.json\z/i)

        text = @files[ProjectFormat.normalize_path(path)]
        raise AgentProjectError, "#{index} points at #{path}, which doesn't exist" if text.nil?

        parsed = parse_json(text, path)
        raise AgentProjectError, "#{path} must hold a JSON object" unless parsed.is_a?(::Hash)

        parsed
      end

      def parse_json(text, path)
        ::JSON.parse(text)
      rescue ::JSON::ParserError => e
        raise AgentProjectError, "#{path} isn't valid JSON: #{e.message}"
      end

      def agents_index
        ProjectFormat.format_index('agents' => @agents.map { |slot| ordered(slot.entry, AGENT_ENTRY_FIELDS) })
      end

      def tools_index
        ProjectFormat.format_index('tools' => @tools.map { |slot| ordered(slot.entry, TOOL_ENTRY_FIELDS) })
      end

      # The entry's fields the CLI writes, in its order, leaving out unset ones.
      def ordered(entry, fields)
        fields.each_with_object({}) { |field, acc| acc[field] = entry[field] if entry.key?(field) }
      end

      def safe_json(tool)
        tool.to_json_string
      rescue StandardError
        nil
      end
    end
  end
end
