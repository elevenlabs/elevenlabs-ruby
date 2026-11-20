# frozen_string_literal: true

require 'json'
require 'uri'
require 'webmock/minitest'
require 'elevenlabs'
require 'elevenlabs/agent_builder'

module Elevenlabs
  module AgentBuilder
    # An in-memory stand-in for the agents and tools endpoints push and pull use, modelled on the JS SDK's
    # tests/custom/agents/agent/fakeServer.ts. Requests go through the generated client and its HTTP stack;
    # WebMock hands each one to this server instead of the network.
    class FakeServer
      BASE = 'https://api.fake.test'

      Call = Struct.new(:verb, :path, :query, :body)

      attr_reader :tools, :agents, :branches, :calls
      # Fails every request whose "METHOD path" matches.
      attr_accessor :fail_on

      def initialize
        @tools = {}
        @agents = {}
        # Branch configs by [agent_id, branch_id]. Only the main branch counts for used_by_agent_id, as in
        # the API.
        @branches = {}
        @calls = []
        @fail_on = nil
        @next = 1
        WebMock::API.stub_request(:any, /\A#{Regexp.escape(BASE)}/o).to_return { |request| handle(request) }
      end

      def add_tool(id, config, used_by = [])
        @tools[id] = { 'config' => config, 'used_by' => used_by }
      end

      def add_agent(id, config)
        @agents[id] = config
      end

      def client
        ::Elevenlabs::Client.new(api_key: 'test-key', base_url: BASE, max_retries: 0)
      end

      # The calls that change something, as "METHOD path".
      def writes
        @calls.reject { |call| call.verb == 'GET' }.map { |call| "#{call.verb} #{call.path}" }
      end

      private

      def handle(request)
        uri = URI(request.uri.to_s)
        method = request.method.to_s.upcase
        query = URI.decode_www_form(uri.query.to_s).to_h
        body = request.body.to_s.empty? ? nil : JSON.parse(request.body)
        @calls << Call.new(verb: method, path: uri.path, query: query, body: body)
        return json({ 'detail' => 'boom' }, 500) if !@fail_on.nil? && "#{method} #{uri.path}".match?(@fail_on)

        _, _, _, kind, id = uri.path.split('/') # /v1/convai/<kind>/<id>
        case kind
        when 'tools' then handle_tool(method, id, query, body)
        when 'agents' then handle_agent(method, id, query, body)
        else raise "unexpected request #{method} #{uri.path}"
        end
      end

      def handle_tool(method, id, query, body)
        if method == 'GET' && id.nil?
          agent_id = query['used_by_agent_id']
          listed = @tools.select { |_id, tool| agent_id.nil? || tool['used_by'].include?(agent_id) }
          return json({ 'tools' => listed.map { |tool_id, tool| tool_response(tool_id, tool['config']) }, 'has_more' => false })
        end
        if method == 'POST'
          tool_id = "tool_new_#{next_id}"
          @tools[tool_id] = { 'config' => body['tool_config'], 'used_by' => [] }
          return json(tool_response(tool_id, body['tool_config']))
        end
        tool = @tools[id]
        return json({ 'detail' => 'not found' }, 404) if tool.nil?

        tool['config'] = body['tool_config'] if method == 'PATCH'
        json(tool_response(id, tool['config']))
      end

      def handle_agent(method, id, query, body)
        if method == 'POST' && id == 'create'
          agent_id = "agent_new_#{next_id}"
          store_agent(agent_id, body)
          return json({ 'agent_id' => agent_id })
        end
        branch_id = query['branch_id']
        unless branch_id.nil?
          key = [id, branch_id]
          @branches[key] = (@branches[key] || {}).merge(body) if method == 'PATCH'
          branch = @branches[key]
          return branch.nil? ? json({ 'detail' => 'not found' }, 404) : json(agent_response(id, branch))
        end
        if method == 'PATCH'
          store_agent(id, (@agents[id] || {}).merge(body))
          return json(agent_response(id, @agents[id]))
        end
        agent = @agents[id]
        agent.nil? ? json({ 'detail' => 'not found' }, 404) : json(agent_response(id, agent))
      end

      def next_id
        id = @next
        @next += 1
        id
      end

      def store_agent(agent_id, config)
        @agents[agent_id] = config
        ids = config.dig('conversation_config', 'agent', 'prompt', 'tool_ids') || []
        (config.dig('workflow', 'nodes') || {}).each_value do |node|
          ids += (node['tools'] || []).map { |tool| tool['tool_id'] }
          ids += node['additional_tool_ids'] || []
        end
        @tools.each do |tool_id, tool|
          tool['used_by'] = tool['used_by'].reject { |a| a == agent_id }
          tool['used_by'] << agent_id if ids.include?(tool_id)
        end
      end

      def tool_response(id, config)
        {
          'id' => id,
          'tool_config' => config,
          'access_info' => { 'is_creator' => true, 'creator_name' => 'a', 'creator_email' => 'a@example.com', 'role' => 'admin' },
          'usage_stats' => { 'avg_latency_secs' => 0.1 },
        }
      end

      # The defaults the API fills into a stored workflow.
      def with_server_defaults(workflow)
        nodes = (workflow['nodes'] || {}).transform_values do |node|
          next node unless node['type'] == 'override_agent'

          {
            'conversation_config' => {}, 'additional_knowledge_base' => [], 'additional_tool_ids' => [],
            'entry_behavior' => 'generate_immediately', 'allow_interruptions_on_entry' => true
          }.merge(node)
        end
        edges = (workflow['edges'] || {}).transform_values { |edge| { 'reroutes' => [] }.merge(edge) }
        { 'prevent_subagent_loops' => false }.merge(workflow).merge('nodes' => nodes, 'edges' => edges)
      end

      def agent_response(id, config)
        response = {
          'agent_id' => id,
          'metadata' => { 'created_at_unix_secs' => 1, 'updated_at_unix_secs' => 1 },
          'version_id' => 'ver_1',
        }.merge(config)
        response['workflow'] = with_server_defaults(config['workflow']) unless config['workflow'].nil?
        response
      end

      def json(body, status = 200)
        { status: status, body: JSON.generate(body), headers: { 'Content-Type' => 'application/json' } }
      end
    end
  end
end
