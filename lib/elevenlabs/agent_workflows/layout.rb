# frozen_string_literal: true

require_relative 'validate'

module Elevenlabs
  module AgentWorkflows
    module Layout
      COLUMN_WIDTH = 300
      ROW_HEIGHT = 200

      module_function

      # Positions for the workflow editor. Nodes that already have a position keep it. The rest go in
      # column = breadth-first depth from the start node, row = order of discovery within that column,
      # skipping rows where a positioned node already sits. Unreachable nodes go in the column after the
      # deepest one.
      def layout(graph)
        depths = Validate.depths_from(graph)
        last_column = ([0] + depths.values).max + 1
        order = depths.keys + graph.nodes.each_key.reject { |id| depths.key?(id) }
        rows = {}
        positions = {}
        occupied = {}
        graph.nodes.each_value do |model|
          position = model['position']
          occupied[[num_key(position['x']), num_key(position['y'])]] = true unless position.nil?
        end

        order.each do |id|
          existing = graph.nodes[id]['position']
          unless existing.nil?
            positions[id] = existing
            next
          end
          column = depths[id] || last_column
          row = rows[column] || 0
          row += 1 while occupied.key?([column * COLUMN_WIDTH, row * ROW_HEIGHT])
          rows[column] = row + 1
          occupied[[column * COLUMN_WIDTH, row * ROW_HEIGHT]] = true
          positions[id] = { 'x' => column * COLUMN_WIDTH, 'y' => row * ROW_HEIGHT }
        end
        positions
      end

      # Normalize a coordinate so a whole float matches the integer grid (300.0 == 300), as Python does.
      def num_key(value)
        value.is_a?(::Float) && value.finite? && value == value.to_i ? value.to_i : value
      end
    end
  end
end
