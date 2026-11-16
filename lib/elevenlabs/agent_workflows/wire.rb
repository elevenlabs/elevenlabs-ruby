# frozen_string_literal: true

require 'json'

module Elevenlabs
  module AgentWorkflows
    # The builder keeps its state in API wire format (snake_case keys, as the REST API and the CLI's
    # agent_configs/*.json use them), with string keys throughout.
    module Wire
      module_function

      # Convert a generated model, or a hash or array holding them, to wire format: plain hashes with
      # string keys, arrays and scalars. Model instances are serialized via #to_h.
      def to_wire(value)
        case value
        when ::Hash
          value.each_with_object({}) { |(k, v), acc| acc[k.to_s] = to_wire(v) }
        when ::Array
          value.map { |item| to_wire(item) }
        else
          return to_wire(value.to_h) if value.respond_to?(:to_h) && !value.is_a?(::String) && !nil_like?(value)

          value
        end
      end

      # Sort object keys at every level and write whole floats as integers, so the JSON matches every
      # other SDK's byte for byte (JavaScript can't tell 300.0 from 300).
      def canonical(value)
        case value
        when ::Hash
          value.keys.sort.to_h { |key| [key, canonical(value[key])] }
        when ::Array
          value.map { |item| canonical(item) }
        when ::Float
          value.finite? && value == value.to_i ? value.to_i : value
        else
          value
        end
      end

      def deep_copy(value)
        case value
        when ::Hash
          value.each_with_object({}) { |(k, v), acc| acc[k] = deep_copy(v) }
        when ::Array
          value.map { |item| deep_copy(item) }
        else
          value
        end
      end

      def nil_like?(value)
        value.nil?
      end
    end
  end
end
