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

      # Integers JavaScript holds exactly. A whole float in this range is written as an integer; one outside
      # it stays a float so json_string writes it the way JavaScript does (1e+21, not an exact integer).
      MAX_SAFE_INTEGER = (2**53) - 1

      # Sorts keys at every level and writes whole floats as integers, as the JavaScript SDK does.
      def canonical(value)
        case value
        when ::Hash
          value.keys.sort.to_h { |key| [key, canonical(value[key])] }
        when ::Array
          value.map { |item| canonical(item) }
        when ::Float
          value.finite? && value == value.to_i && value.abs <= MAX_SAFE_INTEGER ? value.to_i : value
        else
          value
        end
      end

      # +value+ as JSON with 2-space indentation (or +step+), byte for byte what JavaScript's
      # JSON.stringify(value, null, 2) writes: numbers are formatted like Number.prototype.toString.
      def json_string(value, indent = '', step = '  ')
        case value
        when ::Hash
          return '{}' if value.empty?

          inner = "#{indent}#{step}"
          members = value.map { |key, item| "#{inner}#{::JSON.generate(key.to_s)}: #{json_string(item, inner, step)}" }
          "{\n#{members.join(",\n")}\n#{indent}}"
        when ::Array
          return '[]' if value.empty?

          inner = "#{indent}#{step}"
          "[\n#{value.map { |item| "#{inner}#{json_string(item, inner, step)}" }.join(",\n")}\n#{indent}]"
        when ::Float
          js_number(value)
        when ::Integer
          # Exact, even beyond 2^53: rounding as JavaScript would change large IDs.
          value.to_s
        else
          ::JSON.generate(value)
        end
      end

      # A float formatted by ECMAScript's Number::toString: the shortest digits that round-trip, in plain
      # decimal when the decimal exponent is in [-7, 21), otherwise as e.g. 1e-7, 1.5e-7 or 1e+21.
      def js_number(value)
        return 'null' unless value.finite?
        return '0' if value.zero?

        digits, point = decimal_digits(value.abs)
        "#{'-' if value.negative?}#{place_point(digits, point)}"
      end

      # The shortest round-trip digits of a positive float (Ruby's Float#to_s finds them), and +point+ such
      # that the value is 0.<digits> * 10**point.
      def decimal_digits(value)
        mantissa, exponent = value.to_s.split('e')
        whole, fraction = mantissa.split('.')
        digits = whole + fraction.to_s
        point = whole.length + exponent.to_i
        leading = digits.length - digits.sub(/\A0+/, '').length
        [digits[leading..].sub(/0+\z/, ''), point - leading]
      end

      def place_point(digits, point)
        count = digits.length
        if point.between?(count, 21)
          digits + ('0' * (point - count))
        elsif point.positive? && point <= 21
          "#{digits[0, point]}.#{digits[point..]}"
        elsif point > -6 && point <= 0
          "0.#{'0' * -point}#{digits}"
        else
          exponent = point - 1
          mantissa = count == 1 ? digits : "#{digits[0]}.#{digits[1..]}"
          "#{mantissa}e#{exponent.negative? ? '-' : '+'}#{exponent.abs}"
        end
      end
    end
  end
end
