# frozen_string_literal: true

require_relative 'wire'
require_relative 'errors'
require_relative 'destination'

module Elevenlabs
  module AgentWorkflows
    # One edge in the graph. Compared by identity: two edges with the same fields are still two edges.
    class GraphEdge
      attr_accessor :source, :target, :forward_condition, :backward_condition, :id, :extra

      def initialize(source:, target:, forward_condition: nil, backward_condition: nil, id: nil, extra: nil)
        @source = source
        @target = target
        @forward_condition = forward_condition
        @backward_condition = backward_condition
        @id = id
        @extra = extra || {}
      end
    end

    # Mutable state shared by a Workflow and every node handle created from it. Nodes are kept in wire format.
    class WorkflowGraph
      # Canonical option name -> API field, per node type.
      FIELDS = {
        'start' => { 'position' => 'position' },
        'end' => { 'position' => 'position' },
        'override_agent' => {
          'position' => 'position',
          'prompt' => 'additional_prompt',
          'label' => 'label',
          'tool_ids' => 'additional_tool_ids',
          'knowledge_base' => 'additional_knowledge_base',
          'conversation_config' => 'conversation_config',
          'entry_behavior' => 'entry_behavior',
        },
        'tool' => { 'position' => 'position' },
        'phone_number' => {
          'position' => 'position',
          'transfer_type' => 'transfer_type',
          'custom_sip_headers' => 'custom_sip_headers',
          'sip_refer_play_dialtone' => 'sip_refer_play_dialtone',
          'uui' => 'uui',
          'post_dial_digits' => 'post_dial_digits',
        },
        'standalone_agent' => {
          'position' => 'position',
          'delay_ms' => 'delay_ms',
          'transfer_message' => 'transfer_message',
          'enable_transferred_agent_first_message' => 'enable_transferred_agent_first_message',
          'preserve_client_tts_overrides' => 'preserve_client_tts_overrides',
          'preserve_voice_settings' => 'preserve_voice_settings',
        },
      }.freeze

      NODE_KIND = {
        'start' => 'start',
        'end' => 'end',
        'override_agent' => 'subagent',
        'tool' => 'tool',
        'phone_number' => 'phone/SIP transfer',
        'standalone_agent' => 'agent transfer',
      }.freeze

      TRANSFER_TYPES = %w[phone_number standalone_agent].freeze

      attr_accessor :nodes, :edges, :issues, :start_id, :loaded_order, :prevent_subagent_loops

      def initialize
        @nodes = {}
        @edges = []
        @issues = []
        @start_id = 'start_node'
        # Each loaded node's edge_order, as edges. build() keeps this order and appends edges added since.
        @loaded_order = {}
        @prevent_subagent_loops = nil
      end

      def add_node(id, model)
        existing = @nodes[id]
        if existing.nil?
          @nodes[id] = model
        elsif !(existing['type'] == 'end' && model['type'] == 'end')
          issue('duplicate_node_id', "Node id \"#{id}\" is used by more than one node", id)
        end
      end

      def issue(code, message, node_id)
        @issues << WorkflowIssue.new(code: code, severity: 'error', message: message, node_id: node_id)
      end

      # Applies canonical options to a node model. Options set to nil are ignored.
      def apply_options(id, model, options)
        rest = {}
        options.each { |key, value| rest[key.to_s] = value unless value.nil? }
        destination = rest.delete('destination')
        tool_ids = rest.delete('tool_ids')
        schema_overrides = rest.delete('schema_overrides')
        node = model.dup

        node = apply_destination(id, node, destination) unless destination.nil?

        if node['type'] == 'tool'
          node['tools'] = build_tools(id, node, tool_ids, schema_overrides)
        else
          _invalid_option(id, 'schema_overrides', node['type']) unless schema_overrides.nil?
          rest['tool_ids'] = tool_ids.to_a unless tool_ids.nil?
        end

        fields = FIELDS[node['type']] || {}
        rest.each do |key, value|
          field = fields[key]
          if field.nil?
            _invalid_option(id, key, node['type'])
          else
            node[field] = Wire.to_wire(value)
          end
        end
        node
      end

      def load(workflow)
        @nodes = {}
        @edges = []
        @issues = []
        @loaded_order = {}
        @prevent_subagent_loops = workflow['prevent_subagent_loops']

        nodes = workflow['nodes'] || {}
        edges = workflow['edges'] || {}
        nodes.each do |id, node|
          @nodes[id] = node.except('edge_order').transform_values { |value| Wire.deep_copy(value) }
        end
        @start_id = (nodes.find { |_id, node| node['type'] == 'start' } || [])[0] || 'start_node'
        @nodes[@start_id] = { 'type' => 'start' } unless @nodes.key?(@start_id)

        # Rebuild the edge list in each node's edge_order, so that build() reproduces it.
        placed = {}
        add_edge = ->(edge_id) do
          edge = edges[edge_id]
          return if edge.nil? || placed.key?(edge_id)

          rest = edge.each_with_object({}) { |(k, v), acc| acc[k] = Wire.deep_copy(v) }
          graph_edge = GraphEdge.new(
            id: edge_id,
            source: rest.delete('source'),
            target: rest.delete('target'),
            forward_condition: rest.delete('forward_condition'),
            backward_condition: rest.delete('backward_condition'),
            extra: rest,
          )
          placed[edge_id] = graph_edge
          @edges << graph_edge
        end

        nodes.each do |id, node|
          order = node['edge_order'] || []
          order.each { |edge_id| add_edge.call(edge_id) }
          @loaded_order[id] = order.filter_map { |edge_id| placed[edge_id] }
        end
        edges.each_key { |edge_id| add_edge.call(edge_id) }
      end

      private

      def apply_destination(id, node, destination)
        unless TRANSFER_TYPES.include?(node['type'])
          _invalid_option(id, 'destination', node['type'])
          return node
        end

        dest = destination.to_wire
        if dest['type'] == node['type']
          # A new agent destination starts at that agent's default entry point, not the old one's.
          %w[agent_id node_id branch_id].each { |key| node.delete(key) } if node['type'] == 'standalone_agent'
          node.merge!(dest)
        else
          position = node['position']
          node = dest
          node['position'] = position unless position.nil?
        end
        node
      end

      def build_tools(id, node, tool_ids, schema_overrides)
        existing = node['tools'] || []
        ids = tool_ids.nil? ? existing.map { |tool| tool['tool_id'] } : tool_ids.to_a
        (schema_overrides || {}).each_key do |tool_id|
          next if ids.include?(tool_id)

          issue('invalid_option', "Node \"#{id}\" has schema overrides for tool \"#{tool_id}\", which it doesn't run", id)
        end
        ids.map do |tool_id|
          overrides = (schema_overrides || {})[tool_id]
          overrides = if overrides.nil?
                        (existing.find { |tool| tool['tool_id'] == tool_id } || {})['schema_overrides']
                      else
                        Wire.to_wire(overrides)
                      end
          overrides.nil? ? { 'tool_id' => tool_id } : { 'tool_id' => tool_id, 'schema_overrides' => overrides }
        end
      end

      def _invalid_option(id, option, node_type)
        kind = NODE_KIND[node_type] || "\"#{node_type}\""
        issue('invalid_option', "Option \"#{option}\" doesn't apply to #{kind} node \"#{id}\"", id)
      end
    end
  end
end
