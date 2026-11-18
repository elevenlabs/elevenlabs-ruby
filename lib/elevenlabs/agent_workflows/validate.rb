# frozen_string_literal: true

require_relative 'errors'
require_relative 'node_types'

module Elevenlabs
  module AgentWorkflows
    module Validate
      module_function

      # Checks that need the finished graph. Problems found while chaining are already in graph.issues.
      def validate(graph)
        issues = graph.issues.dup
        ends_with_edges = {}

        error = ->(code, message, node_id) do
          issues << WorkflowIssue.new(code: code, severity: 'error', message: message, node_id: node_id)
        end

        merged = reverse_edge_merges(graph)
        connected = {}
        graph.edges.each_with_index do |edge, i|
          next if merged.key?(i)

          # The API allows one edge per pair of nodes, in either direction.
          pair = [edge.source, edge.target].sort
          if connected.key?(pair)
            error.call(
              'duplicate_edge',
              "Edge \"#{edge.source}\" → \"#{edge.target}\" connects two nodes that already have an edge between " \
              'them, and the API allows only one. Give the existing edge a different condition, or remove one',
              edge.source,
            )
          end
          connected[pair] = true
        end

        graph.edges.each do |edge|
          name = "\"#{edge.source}\" → \"#{edge.target}\""
          error.call('self_loop', "Edge #{name} connects a node to itself, which the API doesn't allow", edge.source) if edge.source == edge.target
          [edge.source, edge.target].each do |id|
            error.call('unknown_node', "Edge #{name} refers to unknown node \"#{id}\"", id) unless graph.nodes.key?(id)
          end
          # Forward routing rules apply only when there is a forward transition (a forward condition).
          # A loaded edge can be backward-only, and then source → target does not exist.
          unless edge.forward_condition.nil?
            error.call('edge_into_start', "Edge #{name} points into the start node; go to the first node after it instead", edge.source) if edge.target == graph.start_id

            source_type = (graph.nodes[edge.source] || {})['type']
            condition_type = (edge.forward_condition || {})['type']
            if source_type == 'end' && !ends_with_edges.key?(edge.source)
              ends_with_edges[edge.source] = true
              error.call('end_has_outgoing_edges', "End node \"#{edge.source}\" can't have outgoing edges", edge.source)
            end
            error.call('tool_edge_needs_result', "Edge #{name} leaves a tool node, so it must use on_success() or on_failure()", edge.source) if source_type == 'tool' && condition_type != 'result'
            error.call('result_edge_needs_tool', "Edge #{name} uses on_success()/on_failure(), which only applies to tool nodes", edge.source) if !source_type.nil? && source_type != 'tool' && condition_type == 'result'
          end

          # A backward condition is a second transition the other way, target → source, that the API
          # stores on this same edge. It must obey the same routing rules as any edge leaving the target.
          next if edge.backward_condition.nil?

          back_name = "\"#{edge.target}\" → \"#{edge.source}\""
          back_source_type = (graph.nodes[edge.target] || {})['type']
          back_condition_type = (edge.backward_condition || {})['type']
          error.call('edge_into_start', "Edge #{back_name} points into the start node; go to the first node after it instead", edge.target) if edge.source == graph.start_id
          if back_source_type == 'end' && !ends_with_edges.key?(edge.target)
            ends_with_edges[edge.target] = true
            error.call('end_has_outgoing_edges', "End node \"#{edge.target}\" can't have outgoing edges", edge.target)
          end
          error.call('tool_edge_needs_result', "Edge #{back_name} leaves a tool node, so it must use on_success() or on_failure()", edge.target) if back_source_type == 'tool' && back_condition_type != 'result'
          error.call('result_edge_needs_tool', "Edge #{back_name} uses on_success()/on_failure(), which only applies to tool nodes", edge.target) if !back_source_type.nil? && back_source_type != 'tool' && back_condition_type == 'result'
        end

        graph.nodes.each do |id, model|
          next if NodeTypes.model_knows_node_type?(model['type'])

          issues << WorkflowIssue.new(
            code: 'unknown_node_type',
            severity: 'warning',
            message: "Node \"#{id}\" has type \"#{model['type']}\", which this SDK version doesn't model. build() " \
                     'keeps it as given but can\'t type it, and the generated request model would reject it. ' \
                     'Upgrade the SDK, or send to_json() output directly.',
            node_id: id,
          )
        end

        reachable = depths_from(graph)
        graph.nodes.each_key do |id|
          next if reachable.key?(id)

          issues << WorkflowIssue.new(
            code: 'unreachable_node',
            severity: 'warning',
            message: "Node \"#{id}\" can't be reached from the start node",
            node_id: id,
          )
        end
        issues
      end

      # Edges the API stores as the backward condition of another edge: index of the later edge ->
      # index of the earlier one. The later edge goes the opposite way between the same two nodes, and
      # neither has a backward condition of its own.
      def reverse_edge_merges(graph)
        merges = {}
        taken = {}
        graph.edges.each_with_index do |later, j|
          next if later.source == later.target || !later.backward_condition.nil? || later.forward_condition.nil?

          i = nil
          graph.edges[0...j].each_with_index do |earlier, k|
            next if taken.key?(k) || merges.key?(k)
            next unless earlier.source == later.target && earlier.target == later.source && earlier.backward_condition.nil?

            i = k
            break
          end
          unless i.nil?
            merges[j] = i
            taken[i] = true
          end
        end
        merges
      end

      # Breadth-first depth of every node reachable from the start node, in visiting order. Edges are
      # followed forward first. Only when that runs out does a backward condition lead on, from an
      # edge's target to a source not yet visited.
      def depths_from(graph)
        depths = {}

        visit = ->(id, depth) do
          depths[id] = depth
          queue = [id]
          until queue.empty?
            current = queue.shift
            graph.edges.each do |edge|
              next unless edge.source == current && !edge.forward_condition.nil? && !depths.key?(edge.target) && graph.nodes.key?(edge.target)

              depths[edge.target] = depths[current] + 1
              queue << edge.target
            end
          end
        end

        visit.call(graph.start_id, 0)
        loop do
          back = graph.edges.find do |edge|
            !edge.backward_condition.nil? && depths.key?(edge.target) &&
              !depths.key?(edge.source) && graph.nodes.key?(edge.source)
          end
          return depths if back.nil?

          visit.call(back.source, depths[back.target] + 1)
        end
      end
    end
  end
end
