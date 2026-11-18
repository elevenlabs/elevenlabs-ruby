# frozen_string_literal: true

require 'json'
require_relative '../agent_workflows/wire'

module Elevenlabs
  module AgentTools
    # The tool builder keeps its state in API wire format (snake_case string keys), like the workflow
    # builder, and shares its helpers (AgentWorkflows::Wire) for conversion, copying and canonical output.
    module ToolWire
      # Free-form JSON values, where null is data rather than an unset field.
      FREE_FORM_KEYS = %w[constant_value dynamic_variable_placeholders].freeze

      module_function

      # A JSON string, or a parsed hash or generated model, as a fresh hash in wire format with the API's
      # null (unset) fields removed.
      def parse(data)
        parsed = data.is_a?(::String) ? ::JSON.parse(data) : AgentWorkflows::Wire.to_wire(data)
        strip_nulls(parsed)
      end

      # Drops null fields at every level, except inside free-form values such as constants and
      # dynamic variable placeholders, which are copied as they are. A null +constant_value+ is kept:
      # on a literal whose type list includes "null" it's a real constant, and Schema.from_wire drops it
      # everywhere else.
      def strip_nulls(value)
        case value
        when ::Hash
          value.each_with_object({}) do |(key, item), acc|
            next if item.nil? && key != 'constant_value'

            acc[key] = FREE_FORM_KEYS.include?(key) ? AgentWorkflows::Wire.deep_copy(item) : strip_nulls(item)
          end
        when ::Array
          value.map { |item| strip_nulls(item) }
        else
          value
        end
      end

      # A value given to the builder (a plain value, a generated model, or a symbol for an enum) in wire
      # format: string keys, and symbols as strings.
      def value(raw)
        stringify_symbols(AgentWorkflows::Wire.to_wire(raw))
      end

      def stringify_symbols(value)
        case value
        when ::Hash
          value.transform_values { |item| stringify_symbols(item) }
        when ::Array
          value.map { |item| stringify_symbols(item) }
        when ::Symbol
          value.to_s
        else
          value
        end
      end

      def deep_copy(value)
        AgentWorkflows::Wire.deep_copy(value)
      end

      def canonical(value)
        AgentWorkflows::Wire.canonical(value)
      end
    end
  end
end
