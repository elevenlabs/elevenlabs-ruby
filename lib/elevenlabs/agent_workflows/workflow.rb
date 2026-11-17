# frozen_string_literal: true

require 'json'
require_relative 'wire'
require_relative 'condition'
require_relative 'errors'
require_relative 'graph'
require_relative 'layout'
require_relative 'node'
require_relative 'validate'

module Elevenlabs
  module AgentWorkflows
    # An agent workflow, written as code. The workflow itself is the start node: calling a verb on it
    # branches from the start.
    #
    #   require 'elevenlabs'
    #   require 'elevenlabs/agent_workflows'
    #   include Elevenlabs::AgentWorkflows
    #
    #   wf = Workflow.new
    #   triage = wf.converse('triage', 'Find out what the caller needs')
    #   lookup = triage.when('Caller gave an order number').tool('lookup_order', ['tool_123'])
    #   lookup.on_result(
    #     success: ->(ok) { ok.converse('resolve', 'Explain the order status').end },
    #     failure: ->(failed) { failed.transfer('human', Destination.phone('+15551234567')) },
    #   )
    #
    #   client.agents.update(agent_id: agent_id, workflow: wf.build)
    class Workflow < WorkflowChain
      # +prevent_subagent_loops+ stops the conversation from re-entering a subagent it already visited.
      def initialize(prevent_subagent_loops: nil)
        super(WorkflowGraph.new)
        @graph.add_node(@graph.start_id, { 'type' => 'start' })
        @graph.prevent_subagent_loops = prevent_subagent_loops
      end

      class << self
        # Loads the workflow of an existing agent so it can be edited. Accepts the result of agents.get
        # or its +workflow+ field. Node ids, editor positions and edge order are kept.
        def from_agent(agent)
          workflow = if agent.respond_to?(:nodes)
                       agent
                     elsif agent.respond_to?(:workflow)
                       agent.workflow
                     end
          wf = new
          wf.graph.load(Wire.to_wire(workflow)) unless workflow.nil?
          wf
        end

        # Loads a workflow stored as API-format JSON (snake_case), for example from to_json_string or a
        # CLI agent_configs/*.json file. Accepts a JSON string or a parsed hash, holding either the
        # workflow itself or a whole agent config with a +workflow+ key.
        def from_json(data)
          parsed = data.is_a?(::String) ? ::JSON.parse(data) : data
          raw = parsed.is_a?(::Hash) && parsed.key?('workflow') ? parsed['workflow'] : parsed
          wf = new
          wf.graph.load(raw || {})
          wf
        end
      end

      # @api private — the shared mutable graph, for builder internals and from_agent/from_json.
      attr_reader :graph

      # The id of the start node: "start_node" by default, or whatever a loaded workflow uses.
      def start_id
        @graph.start_id
      end

      # Ids of every node, in the order they were added.
      def node_ids
        @graph.nodes.keys
      end

      # Opens a branch from the start node that is followed when +condition+ holds.
      def when(condition, back: nil)
        AgentWorkflows.branch(@graph, @graph.start_id, condition, back)
      end

      # A handle to an existing node, for editing it or going to it.
      def node(id)
        @graph.issue('unknown_node', "There is no node \"#{id}\"", id) unless @graph.nodes.key?(id)
        WorkflowNode.new(@graph, id)
      end

      # Removes a node and every edge to or from it.
      def remove(id)
        if id == @graph.start_id
          @graph.issue('cannot_remove_start', "The start node can't be removed", id)
          return self
        end
        @graph.nodes.delete(id)
        @graph.edges = @graph.edges.reject { |edge| edge.source == id || edge.target == id }
        self
      end

      # Splices new nodes into the edge from +source_id+ to +target_id+. +insert+ receives a branch
      # carrying that edge's conditions and returns the last new node, which is then connected to
      # +target_id+. Returns that node, or nil if there is no such edge (+insert+ isn't called) or
      # +insert+ returned nothing; build() reports both.
      def insert_between(source_id, target_id, insert)
        graph = @graph
        index = graph.edges.index { |edge| edge.source == source_id && edge.target == target_id }
        if index.nil?
          graph.issue('unknown_edge', "There is no edge from \"#{source_id}\" to \"#{target_id}\" to insert into", source_id)
          return nil
        end
        original = graph.edges.delete_at(index)
        before = graph.edges.length
        last = insert.call(
          WorkflowBranch.new(
            graph,
            EdgeOrigin.new(
              source: source_id,
              forward_condition: original.forward_condition || Condition.always.to_wire,
              backward_condition: original.backward_condition,
            ),
          ),
        )

        # Put the first new edge back where the original was, so the source's edge order is unchanged.
        first_hop = (before...graph.edges.length).find { |i| graph.edges[i].source == source_id }
        unless first_hop.nil?
          edge = graph.edges.delete_at(first_hop)
          graph.edges.insert(index, edge)
          loaded = graph.loaded_order[source_id]
          loaded&.each_with_index do |loaded_edge, slot|
            if loaded_edge.equal?(original)
              loaded[slot] = edge
              break
            end
          end
        end

        unless last.is_a?(WorkflowNode)
          graph.issue('missing_insert_result', "insert_between(\"#{source_id}\", \"#{target_id}\") must return the last inserted node", source_id)
          return nil
        end
        if last.type == 'tool'
          last.on_success.go_to(target_id)
        else
          last.go_to(target_id)
        end
        last
      end

      # Validates the workflow and returns it as the model agents.create and agents.update accept.
      # +on_warning+ is a callable invoked once per non-fatal problem. Raises WorkflowValidationError
      # listing every problem, if the workflow is invalid.
      def build(on_warning: nil)
        ::Elevenlabs::Types::AgentWorkflowRequestModel.load(::JSON.generate(to_wire_hash(on_warning)))
      end

      # The workflow in API format (snake_case keys, sorted at every level), for storing as config.
      # Validates like build().
      def to_json(*_args)
        Wire.canonical(to_wire_hash(nil))
      end

      # to_json as a string with 2-space indentation and a trailing newline: the canonical file format.
      def to_json_string
        "#{::JSON.pretty_generate(to_json)}\n"
      end

      def origin
        EdgeOrigin.new(source: @graph.start_id, forward_condition: Condition.always.to_wire, backward_condition: nil)
      end

      private

      def to_wire_hash(on_warning)
        graph = @graph
        issues = Validate.validate(graph)
        errors = issues.select { |issue| issue.severity == 'error' }
        raise WorkflowValidationError, errors unless errors.empty?

        issues.each { |warning| on_warning.call(warning) if warning.severity == 'warning' } unless on_warning.nil?

        # An edge that goes back the way another one came is sent as that edge's backward condition.
        merges = Validate.reverse_edge_merges(graph)
        kept = graph.edges.each_with_index.reject { |_edge, i| merges.key?(i) }.map(&:first)
        ids = assign_edge_ids(kept)
        id_of = {}
        kept.each_with_index { |edge, idx| id_of[edge] = ids[idx] }

        positions = Layout.layout(graph)
        outgoing = {}
        edges = {}
        graph.edges.each_with_index do |edge, i|
          into = merges[i]
          unless into.nil?
            reverse = graph.edges[into]
            (outgoing[edge.source] ||= []) << reverse
            edges[id_of[reverse]]['backward_condition'] = edge.forward_condition
            next
          end
          (outgoing[edge.source] ||= []) << edge
          # The API lists an edge with a backward condition among its target's outgoing edges as well.
          (outgoing[edge.target] ||= []) << edge unless edge.backward_condition.nil?
          wire = edge.extra.merge('source' => edge.source, 'target' => edge.target)
          wire['forward_condition'] = edge.forward_condition unless edge.forward_condition.nil?
          wire['backward_condition'] = edge.backward_condition unless edge.backward_condition.nil?
          edges[id_of[edge]] = wire
        end

        nodes = {}
        graph.nodes.each do |node_id, model|
          order = edge_order(graph.loaded_order[node_id] || [], outgoing[node_id] || [])
          nodes[node_id] = model.merge(
            'position' => positions[node_id],
            'edge_order' => order.map { |edge| id_of[edge] },
          )
        end
        workflow = { 'nodes' => nodes, 'edges' => edges }
        workflow['prevent_subagent_loops'] = graph.prevent_subagent_loops unless graph.prevent_subagent_loops.nil?
        Wire.deep_copy(workflow)
      end

      # A loaded node's order for the edges it still has, then any others in edge-list order.
      def edge_order(loaded, current)
        kept = loaded.select { |edge| current.any? { |c| c.equal?(edge) } }
        rest = current.reject { |edge| kept.any? { |k| k.equal?(edge) } }
        kept + rest
      end

      # Loaded edges keep their ids. New ones get source__target, with __2, __3... on collision.
      def assign_edge_ids(edges)
        taken = edges.filter_map(&:id)
        edges.map do |edge|
          next edge.id unless edge.id.nil?

          base = "#{edge.source}__#{edge.target}"
          edge_id = base
          n = 2
          while taken.include?(edge_id)
            edge_id = "#{base}__#{n}"
            n += 1
          end
          taken << edge_id
          edge_id
        end
      end
    end
  end
end
